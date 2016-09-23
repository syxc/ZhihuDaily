//
//  LatestNews.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper

/// 最新消息
struct LatestNews {
  var date: String?
  
  var stories: [Story]?
  
  var top_stories: [TopStory]?
  
  var description: String {
    return "Date: \(date), Stories: \(stories), TopStory: \(top_stories)\n"
  }
}

extension LatestNews: Mappable {
  init?(_ map: Map) {}
  
  mutating func mapping(map: Map) {
    date        <- map["date"]
    stories     <- map["stories"]
    top_stories <- map["top_stories"]
  }
}
