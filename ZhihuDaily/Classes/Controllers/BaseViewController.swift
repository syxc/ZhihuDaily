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
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if statusBarShouldLight {
      return UIStatusBarStyle.LightContent
    }
    return UIStatusBarStyle.Default
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
