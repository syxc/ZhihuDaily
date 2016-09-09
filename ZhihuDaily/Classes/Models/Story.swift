//
//  Story.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/3.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper

/// 当日新闻
struct Story {
  /// 新闻标题
  var title: String?
  
  /// 供 Google Analytics 使用
  var ga_prefix: String?
  
  /// 图像地址
  var images: [String]?
  
  var type: Int?
  
  /// url 与 share_url 中最后的数字（应为内容的 id）
  var id: Int?
  
  var description: String {
    return "Title: \(title), GA_Prefix: \(ga_prefix), Images: \(images), Type: \(type), Id: \(id)\n"
  }
}

extension Story: Mappable {
  init?(_ map: Map) {}
  
  mutating func mapping(map: Map) {
    title     <- map["title"]
    ga_prefix <- map["ga_prefix"]
    images    <- map["images"]
    type      <- map["type"]
    id        <- map["id"]
  }
}
