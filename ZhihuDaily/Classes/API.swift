//
//  ZhihuDaily.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/16.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Foundation


// MARK: - Provider support

private extension String {
  var URLEscapedString: String {
    return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
  }
}

// MARK: - ZhihuAPI URL Router

/* 参考 https://github.com/izzyleung/ZhihuDailyPurify/wiki/知乎日报-API-分析 */

/**
ZhihuAPI URL Router

- SplashScreen: 启动界面图像获取
- LatestNews:   最新消息
*/
public enum API: String {
  
  /// 启动界面图像获取
  case SplashScreen
  
  /// 最新消息
  case LatestNews
  
}


extension API {
  
  var baseURL: NSURL {
    return NSURL(string: "http://news-at.zhihu.com/api/4")!
  }
  
  var description: String {
    switch self {
    case .SplashScreen:
      return router("/start-image/%@")
    case .LatestNews:
      return router("/news/latest")
    }
  }
  
  var debugDescription: String {
    return "API (rawValue: \(rawValue))"
  }
  
  var raw: String {
    return description
  }
  
  /**
   URL路由
   
   - parameter path: sub url
   
   - returns: absolute url
   */
  private func router(path: String) -> String {
    return baseURL.URLByAppendingPathComponent(path as String).absoluteString
  }
  
}
