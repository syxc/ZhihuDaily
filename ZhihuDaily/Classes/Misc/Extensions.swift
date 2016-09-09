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

// MARK: - NSObject

extension NSObject {
  public func objectOrBlank(object: AnyObject?) -> AnyObject {
    if object != nil {
      return object!
    }
    print("\n--- Doesn’t contain a object ---\n")
    return ""
  }
}


// MARK: - UIColor

extension UIColor {
  static func themeColor() -> UIColor {
    return HexColor(FYColors.color_primary)
  }
  
  static func statusBarBackgroundColor() -> UIColor {
    return HexColor(FYColors.color_primary_dark)
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
  
  public func setStatusBarBackgroundColor(color: UIColor) {
    guard let statusBar = UIApplication.sharedApplication()
      .valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else {
        return
    }
    statusBar.backgroundColor = color
  }
}


// MARK: - UIView

extension UIView {
  public func initializeBlurEffect() {
    let height = self.frame.size.height
    let width = self.frame.size.width
    let x = self.frame.origin.x
    let y = self.frame.origin.y
    
    let blurEffect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
    let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
    
    let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
    let blurEffectView:UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
    
    blurEffectView.frame = CGRectMake(x, y, width, height)
    blurEffectView.contentView.addSubview(vibrancyEffectView)
    
    self.addSubview(blurEffectView)
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


// MARK: - UITableViewCell

extension UITableViewCell {
  /**
   Hide separator line on one UITableViewCell
   */
  public func hideSeparatorLine() {
    self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.width, bottom: 0, right: 0)
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
  
  var length: Int {
    return characters.count
  }
}
