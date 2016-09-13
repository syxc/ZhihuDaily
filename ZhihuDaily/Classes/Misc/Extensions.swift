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

///--------------------------------
/// @name Foundation
///--------------------------------

// MARK: - NSObject

extension NSObject {
  public func objectOrBlank(object: AnyObject?) -> AnyObject {
    if object != nil {
      return object!
    }
    print("\n--- Doesn’t contain a object ---\n")
    return ""
  }
  
  /// Perform selector after delay in swift
  public func callSelectorAsync(selector: Selector, object: AnyObject?, delay: NSTimeInterval) -> NSTimer {
    let timer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self, selector: selector, userInfo: object, repeats: false)
    return timer
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
    return self.characters.count
  }
  
  /// Localized String
  var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: self, comment: "")
  }
  
  /// Localized String with comment
  public func localizedStringWithComment(comment: String) -> String {
    return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: self, comment: comment)
  }
}

///--------------------------------
/// @name UIKit
///--------------------------------

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

// MARK: - UIApplication

extension UIApplication {
  class func topViewController(base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
      if let selected = tab.selectedViewController {
        return topViewController(selected)
      }
    }
    if let presented = base?.presentedViewController {
      return topViewController(presented)
    }
    return base
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
