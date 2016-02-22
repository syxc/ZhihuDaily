//
//  BaseViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/2.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  var statusBarShouldLight = false
  var animatedOnNavigationBar = true
  
  var hud: ProgressHUD!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Setup ProgressHUD
    self.hud = ProgressHUD(view: self.view)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if statusBarShouldLight {
      return UIStatusBarStyle.LightContent
    }
    return UIStatusBarStyle.Default
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let navigationController = navigationController else {
      return
    }
    
    /* Config navigationBar style */
    navigationController.navigationBar.translucent = true
    
    if statusBarShouldLight {
      navigationController.navigationBar.tintColor = UIColor.whiteColor()
      navigationController.navigationBar.barTintColor = UIColor.themeColor()
      navigationController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    } else {
      navigationController.navigationBar.tintColor = UIColor.themeColor()
      navigationController.navigationBar.barTintColor = nil
      navigationController.navigationBar.barStyle = UIBarStyle.Default
    }
    
    if navigationController.navigationBarHidden {
      navigationController.setNavigationBarHidden(false, animated: animatedOnNavigationBar)
    }
    
    self.setNeedsStatusBarAppearanceUpdate()
  }
  
  override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
    
    if let navigationController = navigationController {
      guard navigationController.topViewController == self else {
        return
      }
    }
    
    super.performSegueWithIdentifier(identifier, sender: sender)
  }
  
}
