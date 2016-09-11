//
//  FYScheme.swift
//  ZhihuDaily
//
//  Created by syxc on 2016/9/9.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation

enum FYScheme: String {
  
  case Home = "home"
  case News_Detail = "news_detail"
  case About = "about"
  
  static let allValues = [
    Home,
    News_Detail,
    About
  ]
  
  var description: String {
    return self.rawValue
  }
  
  var debugDescription: String {
    return "FYScheme (rawValue: \(rawValue))"
  }
  
  var raw: String {
    return description
  }
}

/* Custom scheme */
let fyScheme = "fyzhihudaily"

func scheme(scheme: FYScheme) -> String {
  guard let scheme: String = String(format: "%@://%@", fyScheme, scheme.raw) else {
    return ""
  }
  return scheme
}
