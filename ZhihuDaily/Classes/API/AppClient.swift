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

public class AppClient: ZhihuAPI {
  
  static var shareClient: AppClient {
    struct Static {
      static let client = AppClient()
    }
    return Static.client
  }
  
  // MARK: - ZhihuAPI methods
  
  func fetchSplashScreen(resolution: SplashResolution) -> Promise<NSDictionary> {
    let url = String(format: requestURL(API.fetch_splashScreen.raw), resolution.description)
    log.info("url: \(url)")
    return Promise { fulfill, reject in
      Alamofire.request(.GET, url)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success(let dict):
            fulfill(dict as! NSDictionary)
          case .Failure(let error):
            reject(error)
          }
      }
    }
  }
  
  func fetchLatestNews() -> Promise<NSDictionary> {
    let url = requestURL(API.fetch_latestNews.raw)
    log.info("url: \(url)")
    return Promise { fulfill, reject in
      Alamofire.request(.GET, url)
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success(let dict):
            fulfill(dict as! NSDictionary)
          case .Failure(let error):
            reject(error)
          }
      }
    }
  }
  
}

extension AppClient {
  var baseUrl: String {
    if appDebug {
      return "http://news-at.zhihu.com/api/4"
    }
    return "https://news-at.zhihu.com/api/4"
  }
  
  func requestURL(url: String?) -> String {
    return String(format: "%@%@", baseUrl, url!)
  }
}
