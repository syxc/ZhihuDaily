//
//  FYNavigationController.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/2.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

class FYNavigationController: UINavigationController,
UIGestureRecognizerDelegate, UINavigationControllerDelegate {
  
  // MARK: StatusBarStyle
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return super.preferredStatusBarStyle()
  }
  
  override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
    return super.preferredStatusBarUpdateAnimation()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return super.prefersStatusBarHidden()
  }
  
  
  override func viewDidLoad() {
    weak var weakSelf = self
    if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
      self.interactivePopGestureRecognizer?.delegate = weakSelf
      self.delegate = weakSelf
    }
  }
  
  override func pushViewController(viewController: UIViewController, animated: Bool) {
    if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) && animated {
      self.interactivePopGestureRecognizer?.enabled = false
    }
    
    super.pushViewController(viewController, animated: animated)
  }
  
  override func popToRootViewControllerAnimated(animated: Bool) -> [UIViewController]? {
    if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) && animated {
      self.interactivePopGestureRecognizer?.enabled = false
    }
    
    return super.popToRootViewControllerAnimated(animated)
  }
  
  override func popToViewController(viewController: UIViewController, animated: Bool) -> [UIViewController]? {
    if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
      self.interactivePopGestureRecognizer?.enabled = false
    }
    
    return super.popToViewController(viewController, animated: animated)
  }
  
  
  // MARK: UINavigationControllerDelegate
  
  func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
    if self.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
      self.interactivePopGestureRecognizer?.enabled = true
    }
  }
  
  func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer == self.interactivePopGestureRecognizer {
      if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
        return false
      }
    }
    
    return true
  }
  
}
