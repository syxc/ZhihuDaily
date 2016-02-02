//
//  BaseNavigationController.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/2.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
  
  var statusBarShouldLight = true
  
  override func viewWillAppear(animated: Bool) {
    if statusBarShouldLight {
      navigationBar.tintColor = UIColor.whiteColor()
      navigationBar.barTintColor = UIColor.themeColor()
      navigationBar.barStyle = .BlackTranslucent
    } else {
      navigationBar.tintColor = UIColor.themeColor()
      navigationBar.barTintColor = nil
      navigationBar.barStyle = .Default
    }
    self.setNeedsStatusBarAppearanceUpdate()
    super.viewWillAppear(animated);
  }
}
