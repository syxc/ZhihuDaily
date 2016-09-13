//
//  NewsDetailVC.swift
//  ZhihuDaily
//
//  Copyright (c) 2016年 syxc
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import PromiseKit

/**
 新闻详情
 */
class NewsDetailVC: FYWebViewController {
  
  var newsID: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if newsID != nil && newsID?.length > 0 {
      loadNewsDetail(newsID!)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  deinit {
    
  }
  
  /**
   获取新闻详情
   
   - parameter id: 新闻ID
   */
  private func loadNewsDetail(id: String) {
    let client = AppClient.shareClient
    
    weak var weakSelf = self
    
    firstly {
        client.fetchNewsDetail(id)
      }.then { newsItem -> Void in
        log.info("newsItem=\(newsItem)")
        if let newsItem: News = newsItem {
          weakSelf!.renderNewsDetailTemplate(newsItem)
        }
      }.always {
        self.setNetworkActivityIndicatorVisible(false)
      }.error { error in
        log.error("error=\(error)")
    }
  }
  
  private func renderNewsDetailTemplate(newsItem: News) {
    self.htmlString = loadHTMLByMGTemplateEngine(newsItem)
    self.loadHTMLString(self.htmlString)
  }
  
  private func loadHTMLByMGTemplateEngine(data: News) -> String {
    let templatePath = NSBundle.mainBundle().pathForResource("news", ofType: "html")
    let engine = MGTemplateEngine.init()
    engine.matcher = ICUTemplateMatcher(templateEngine: engine)
    engine.setObject(objectOrBlank(data.title), forKey: "title")
    engine.setObject(objectOrBlank(data.css![0]), forKey: "css")
    engine.setObject(objectOrBlank(data.share_url), forKey: "share_url")
    engine.setObject(objectOrBlank(data.image), forKey: "image")
    engine.setObject(objectOrBlank(data.image_source), forKey: "image_source")
    engine.setObject(objectOrBlank(data.body), forKey: "content")
    return engine.processTemplateInFileAtPath(templatePath, withVariables: nil)
  }
}
