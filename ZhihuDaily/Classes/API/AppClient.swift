//
//  AppClient.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Foundation
import Alamofire

final class AppClient: ZhihuAPI {
  
  static var instance: AppClient {
    struct Static {
      static let instance = AppClient()
    }
    return Static.instance
  }
  
  
  // MARK: - ZhihuAPI methods
  
  func fetchSplashScreen(resolution: SplashResolution?, callback: Callback) -> Void {
    let url = String(format: api_fetch_splashScreen, (resolution?.description)!)
    println("url: \(url)")    
    Alamofire.request(.GET, url).responseJSON { (response) -> Void in
      // fail
      if let error = response.result.error {
        callback(nil, error)
      } else {
        // success
        guard let json = response.result.value else {
          return
        }
        callback(json, nil)
      }
    }
  }
  
  func fetchLatestNews(callback: Callback) -> Void {
    let url = api_fetch_latestNews
    dLog("url: \(url)")
    Alamofire.request(.GET, url).responseJSON { (response) -> Void in
      // fail
      if let error = response.result.error {
        callback(nil, error)
      } else {
        // success
        guard let json = response.result.value else {
          return
        }
        callback(json, nil)
      }
    }
  }
  
}
