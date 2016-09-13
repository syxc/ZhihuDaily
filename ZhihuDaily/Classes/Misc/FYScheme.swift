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

func scheme(scheme: FYScheme, params: Dictionary<String, String>? = nil) -> String {
  var string: String = ""
  if params != nil && params?.count > 0 {
    var paramString = ""
    if params?.count == 1 {
      for key in params!.keys {
        paramString += "\(key)=\(params![key]!)"
      }
    } else {
      for key in params!.keys {
        paramString += "\(key)=\(params![key]!)&"
      }
      if paramString.hasSuffix("&") {
        paramString = String(paramString.characters.dropLast())
      }
    }
    string = String(format: "%@://%@?%@", fyScheme, scheme.raw, paramString)
  } else {
    string = String(format: "%@://%@", fyScheme, scheme.raw)
  }
  return string
}

