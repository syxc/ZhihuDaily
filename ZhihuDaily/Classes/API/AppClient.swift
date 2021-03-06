//
//  AppClient.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

public class AppClient: ZhihuAPI {
  
  static var shareClient: AppClient {
    struct Static {
      static let client = AppClient()
    }
    return Static.client
  }
  
  // MARK: - ZhihuAPI methods
  
  func fetchSplashScreen(resolution: SplashResolution) -> Promise<Splash> {
    let url = String(format: requestURL(API.fetch_splashScreen.raw), resolution.description)
    log.info("url: \(url)")
    
    self.setNetworkActivityIndicatorVisible()
    
    return Promise { fulfill, reject in
      Alamofire.request(.GET, url, headers: basicHeaders())
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success(let dict):
            log.info("dict=\(dict)")
            
            guard let splash = Mapper<Splash>().map(dict) else {
              return
            }
            
            fulfill(splash)
          case .Failure(let error):
            reject(error)
          }
      }
    }
  }
  
  func fetchLatestNews() -> Promise<LatestNews> {
    let url = requestURL(API.fetch_latestNews.raw)
    log.info("url: \(url)")
    
    self.setNetworkActivityIndicatorVisible()
    
    return Promise { fulfill, reject in
      Alamofire.request(.GET, url, headers: basicHeaders())
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success(let dict):
            log.info("dict=\(dict)")
            
            guard let news = Mapper<LatestNews>().map(dict) else {
              return
            }
            
            fulfill(news)
          case .Failure(let error):
            reject(error)
          }
      }
    }
  }
  
  func fetchNewsDetail(id: String) -> Promise<News> {
    let url = requestURL(String(format: API.fetch_news_detail.raw, id))
    log.info("url: \(url)")
    
    self.setNetworkActivityIndicatorVisible()
    
    return Promise { fulfill, reject in
      Alamofire.request(.GET, url, headers: basicHeaders())
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success(let dict):
            log.info("dict=\(dict)")
            
            guard let newsItem = Mapper<News>().map(dict) else {
              return
            }
            
            fulfill(newsItem)
          case .Failure(let error):
            reject(error)
          }
      }
    }
  }
}

internal extension AppClient {
  var baseUrl: String {
    if appDebug {
      return "http://news-at.zhihu.com/api/4"
    }
    return "https://news-at.zhihu.com/api/4"
  }
  
  func requestURL(url: String?) -> String {
    return String(format: "%@%@", baseUrl, url!)
  }
  
  func basicHeaders() -> Dictionary<String, String> {
    /* Just test data */
    let app = "ZhihuDaily"
    let author = "syxc"
    let credentialData = "\(app):\(author)".dataUsingEncoding(NSUTF8StringEncoding)!
    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
    let headers = ["Authorization": "Basic \(base64Credentials)"]
    return headers
  }
  
  func setNetworkActivityIndicatorVisible(visible: Bool = true) {
    dispatch_async(dispatch_get_main_queue()) {
      UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
    }
  }
}
