//
//  Extensions.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/20.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation
import UIKit
import Hue

// MARK: - UIColor

extension UIColor {
  
  static func themeColor() -> UIColor {
    return UIColor.hex(FYColors.theme)
  }
  
  static func hudBackgroundColor() -> UIColor {
    return UIColor.hex("#000000").alpha(0.80)
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