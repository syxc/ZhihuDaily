//
//  API.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/24.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation

// MARK: - ZhihuAPI URL

/* 参考 https://github.com/izzyleung/ZhihuDailyPurify/wiki/知乎日报-API-分析 */

enum API: String {
  /// 启动界面图像获取
  case fetch_splashScreen = "/start-image/%@"
  
  /// 最新消息
  case fetch_latestNews = "/news/latest"
}

extension API {
  var raw: String {
    return self.rawValue
  }
}
