//
//  Api.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/24.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation

// MARK: - ZhihuAPI URL

/* 参考 https://github.com/izzyleung/ZhihuDailyPurify/wiki/知乎日报-API-分析 */

enum Api: String {
  /// 启动界面图像获取
  case fetch_splashScreen = "/start-image/%@"
  
  /// 最新消息
  case fetch_latestNews = "/news/latest"
}

extension Api {
  var baseUrl: String {
    guard appDebug else {
      return "http://news-at.zhihu.com/api/4"
    }
    return "https://news-at.zhihu.com/api/4"
  }
  
  var raw: String {
    return String(format: "%@%@", baseUrl, self.rawValue)
  }
}
