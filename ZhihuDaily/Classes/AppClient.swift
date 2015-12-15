//
//  AppClient.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Alamofire
import Foundation


struct AppClient: ZhihuAPI {

  // MARK: - ZhihuAPI methods

  static func fetchSplashScreen(resolution: SplashResolution?, callback: Callback) -> Void {
    let url = String(format: ZhihuDaily.SplashScreen.raw, (resolution?.raw)!)
    print("url: \(url)")
    Alamofire.request(.GET, url).responseJSON {
      (response) -> Void in
      // fail
      if let error = response.result.error {
        callback(nil, error)
      } else {
        // success
        if let json = response.result.value {
          callback(json, nil)
        }
      }
    }
  }

  static func fetchLatestNews() {

  }

}
