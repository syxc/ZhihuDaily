//
//  SplashResolution.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Foundation

/**
 * 图像分辨率
 */
enum SplashResolution: String {
  
  case _320 = "320*432"
  case _480 = "480*728"
  case _720 = "720*1184"
  case _1080 = "1080*1776"
  
  static let allValues = [_320, _480, _720, _1080]
  
  var description: String {
    return "\(self.rawValue)"
  }
  
  var debugDescription: String {
<<<<<<< HEAD:ZhihuDaily/Classes/SplashResolution.swift
    return "SplashResolution (rawValue: \(rawValue))"
  }
  
  var raw: String {
    return description
=======
    return "SplashResolution (rawValue: \(self.rawValue))"
>>>>>>> dev:ZhihuDaily/Classes/Misc/SplashResolution.swift
  }
}