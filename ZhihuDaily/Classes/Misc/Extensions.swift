//
//  Extensions.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/20.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import ChameleonFramework

// MARK: - UIColor

extension UIColor {
  static func themeColor() -> UIColor {
    return HexColor(FYColors.theme)
  }
  
  static func hudBackgroundColor() -> UIColor {
    return HexColor("#000000", 0.80);
  }
}


// MARK: - UINavigationController

extension UINavigationController {
  public override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return (self.topViewController?.preferredStatusBarStyle())!
  }
  
  public override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return (self.topViewController?.preferredStatusBarUpdateAnimation())!
  }
  
  public override func prefersStatusBarHidden() -> Bool {
    return (self.topViewController?.prefersStatusBarHidden())!
  }
}


// MARK: - UIViewController

extension UIViewController {
  public func setNetworkActivityIndicatorVisible(visible: Bool = true) {
    dispatch_async(dispatch_get_main_queue()) {
      UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
    }
  }
}


// MARK: - UITableView

extension UITableView {
  /* Solve the MBProgressHud behind the UITableView divider (seperator). */
  public override func didAddSubview(subview: UIView) {
    for view in self.subviews {
      if view.isKindOfClass(MBProgressHUD.classForCoder()) {
        self.bringSubviewToFront(view)
        break
      }
    }
  }
}


// MARK: - String

extension String {
  var ns: NSString {
    return self as NSString
  }
  
  var pathExtension: String? {
    return ns.pathExtension
  }
  
  var lastPathComponent: String? {
    return ns.lastPathComponent
  }
}