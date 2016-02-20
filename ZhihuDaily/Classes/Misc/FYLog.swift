//
//  FYLog.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/20.
//  Copyright © 2016年 syxc. All rights reserved.
//
//  println and logger macros to abbreviate NSLog.
//  Use like this:
//
//  logger("Log this!")
//
//  via: https://gist.github.com/xmzio/fccd29fc945de7924b71
//

import Foundation
import UIKit

#if DEBUG
  /// Custom println
  func println(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
  }
  
  /// logger
  func logger(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
  }
  
  /// Show logger in UIAlertView
  func uLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    let alertView = UIAlertView(title: "[\(filename.lastPathComponent):\(line)]", message: "\(function) - \(message)",  delegate:nil, cancelButtonTitle:"OK")
    alertView.show()
  }
#else
  func println(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
  func logger(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
  func uLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
#endif