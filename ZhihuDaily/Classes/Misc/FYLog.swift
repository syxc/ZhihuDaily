//
//  FYLog.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/20.
//  Copyright © 2016年 syxc. All rights reserved.
//
//  println, dLog and aLog macros to abbreviate NSLog.
//  Use like this:
//
//  dLog("Log this!")
//

import Foundation
import UIKit

#if DEBUG
  /// println
  func println(object: Any, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(object)")
  }
  
  /// dLog
  func dLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
  }
  
  /// uLog
  func uLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    let alertView = UIAlertView(title: "[\(filename.lastPathComponent):\(line)]", message: "\(function) - \(message)",  delegate:nil, cancelButtonTitle:"OK")
    alertView.show()
  }
#else
  func println(object: Any, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
  func dLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
  func uLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {}
#endif

/// aLog
func aLog(message: String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
  #if DEBUG
    NSLog("[\(filename.lastPathComponent):\(line)] \(function) - \(message)")
  #endif
}
