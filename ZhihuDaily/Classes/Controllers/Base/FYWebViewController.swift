//
//  FYWebViewController.swift
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
import WebKit

class FYWebViewController: BaseViewController, WKNavigationDelegate, WKUIDelegate {
  
  /// The main and only UIProgressView
  private var progressView: UIProgressView?
  /// 网页提供方
  private var providerLabel: UILabel?
  
  private var estimatedProgress: Float = 0.0
  
  private var webView: WKWebView?
  
  // KVO
  private var webBrowserContext = 0
  
  var url: NSURL?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupWKWebView()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    // Add progressView
    self.navigationController?.navigationBar.addSubview(progressView!)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    progressView?.removeFromSuperview()
  }
  
  deinit {
    if webView != nil {
      if self.isViewLoaded() {
        webView!.removeObserver(self, forKeyPath: "estimatedProgress", context: &webBrowserContext)
        webView!.removeObserver(self, forKeyPath: "title", context: &webBrowserContext)
      }
      
      webView!.stopLoading()
      webView!.navigationDelegate = nil
      webView!.UIDelegate = nil
      webView = nil
    }
  }
  
  
  // MARK: - Setup
  
  private func setupWKWebView() {
    webView = WKWebView(frame: self.view.bounds)
    webView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    webView!.navigationDelegate = self
    webView!.UIDelegate = self
    self.view.addSubview(webView!)
    
    webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: &webBrowserContext)
    webView?.addObserver(self, forKeyPath: "title", options: .New, context: &webBrowserContext)
    
    progressView = UIProgressView(progressViewStyle: .Default)
    progressView?.tintColor = UIColor.themeColor()
    progressView?.trackTintColor = UIColor.clearColor()
    progressView?.frame = CGRectMake(0, self.navigationController!.navigationBar.frame.size.height - progressView!.frame.size.height, self.view.frame.size.width, progressView!.frame.size.height)
    progressView?.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
    
    assert(self.url != nil, "self.url is nil")
    
    if (self.url != nil && self.url?.URLString.length > 0) {
      weak var weakSelf = self
      dispatch_async(dispatch_get_main_queue(), {
        let request = NSURLRequest(URL: weakSelf!.url!, cachePolicy: .ReturnCacheDataElseLoad, timeoutInterval: 30)
        weakSelf!.webView!.loadRequest(request)
      })
    }
  }
  
  
  // MARK: - Estimated Progress KVO (WKWebView)
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if let change = change where context == &webBrowserContext {
      let value = change[NSKeyValueChangeNewKey]
      if (keyPath == "estimatedProgress" && object!.isEqual(self.webView)) {
        self.progressView?.alpha = 1.0
        
        let animated = Float((self.webView?.estimatedProgress)!) > self.progressView?.progress
        self.progressView?.setProgress(Float((self.webView?.estimatedProgress)!), animated: animated)
        
        // Once complete, fade out UIProgressView
        if (self.webView?.estimatedProgress >= 1.0) {
          weak var weakSelf = self
          UIView.animateWithDuration(0.3, delay: 0.3, options: .CurveEaseOut, animations: {
              weakSelf?.progressView?.alpha = 0.0
            }, completion: { _ in
              weakSelf?.progressView?.setProgress(0.0, animated: false)
          })
        }
      } else if (keyPath == "title" && object!.isEqual(self.webView)) {
        self.title = "\(value!)"
      }
    } else {
      super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
  }
  
  
  // MARK: - WKNavigationDelegate
  
  func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    setNetworkActivityIndicatorVisible()
  }
  
  func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
    
  }
  
  /**
   对于 HTTPS 的都会触发此代理，如果不要求验证，传默认就行，
   如果需要证书验证，与使用 AFN 进行 HTTPS 证书验证是一样的
   */
  func webView(webView: WKWebView, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
    completionHandler(.PerformDefaultHandling, nil)
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    setNetworkActivityIndicatorVisible(false)
  }
  
  func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    setNetworkActivityIndicatorVisible(false)
  }
  
  
  // MARK: - WKUIDelegate
  
  func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
    
    let alertController = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) in
      completionHandler()
    }))
    
    self.presentViewController(alertController, animated: true) {
      
    }
  }
  
}
