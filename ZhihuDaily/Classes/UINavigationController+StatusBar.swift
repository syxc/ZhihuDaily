//
//  UINavigationController+StatusBar.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/3.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

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
