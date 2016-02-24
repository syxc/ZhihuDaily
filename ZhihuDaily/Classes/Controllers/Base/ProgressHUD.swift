//
//  ProgressHUD.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/22.
//  Copyright © 2016年 syxc. All rights reserved.
//

import Foundation
import MBProgressHUD

final class ProgressHUD: NSObject {
  var view: UIView?
  var hud: MBProgressHUD?
  
  var infoImage: UIImage?
  var successImage: UIImage?
  var errorImage: UIImage?
  
  let defaultDelay = 0.80
  let statusDelay = 1.50
  let detailsLabelFont = UIFont.systemFontOfSize(14.0)
  
  init(view: UIView?) {
    super.init()
    
    guard let baseView = view else {
      log.info("baseView is null")
      return
    }
    
    /* MBProgressHUD required */
    self.view = baseView
    self.setup()
  }
  
  func setup() {
    /* Status icon */
    self.infoImage = UIImage(contentsOfFile: imageBundle().pathForResource("info", ofType: "png")!)
    self.successImage = UIImage(contentsOfFile: imageBundle().pathForResource("success", ofType: "png")!)
    self.errorImage = UIImage(contentsOfFile: imageBundle().pathForResource("error", ofType: "png")!)
  }
  
  // MARK: - HUD
  
  func sharedHUD() -> MBProgressHUD! {
    if self.hud == nil {
      self.hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    return self.hud
  }
  
  func show() {
    guard let hud = sharedHUD() else {
      self.hud = nil
      return
    }
    self.hud = hud
  }
  
  func showToast(message: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = message else {
      return
    }
    
    hud.mode = MBProgressHUDMode.Text
    hud.labelText = ""
    hud.detailsLabelText = text
    hud.detailsLabelFont = detailsLabelFont
    hud.hide(true, afterDelay: statusDelay)
  }
  
  func showWithStatus(status: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = status else {
      return
    }
    
    hud.labelText = ""
    hud.detailsLabelText = text
    hud.detailsLabelFont = detailsLabelFont
  }
  
  func showInfoWithStatus(status: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = status else {
      return
    }
    
    hud.mode = MBProgressHUDMode.CustomView
    hud.customView = imageWithTintColor(self.infoImage)
    hud.labelText = ""
    hud.detailsLabelText = text
    hud.detailsLabelFont = detailsLabelFont
    hud.hide(true, afterDelay: statusDelay)
  }
  
  func showSuccessWithStatus(status: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = status else {
      return
    }
    
    hud.mode = MBProgressHUDMode.CustomView
    hud.customView = imageWithTintColor(self.successImage)
    hud.labelText = ""
    hud.detailsLabelText = text
    hud.detailsLabelFont = detailsLabelFont
    hud.hide(true, afterDelay: statusDelay)
  }
  
  func showErrorWithStatus(status: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = status else {
      return
    }
    
    hud.mode = MBProgressHUDMode.CustomView
    hud.customView = imageWithTintColor(self.errorImage)
    hud.labelText = ""
    hud.detailsLabelText = text
    hud.detailsLabelFont = detailsLabelFont
    hud.hide(true, afterDelay: statusDelay)
  }
  
  /* Just test */
  func asyncShowWithStatus(status: String?) {
    guard let hud = sharedHUD() else {
      return
    }
    
    guard let text = status else {
      return
    }
    
    hud.labelText = text
    hud.showAnimated(true, whileExecutingBlock: {
      // Async task, Run in background
      sleep(10)
      }) {
        hud.hide(true, afterDelay: self.statusDelay)
    }
  }
  
  func dismiss() {
    guard let hud = sharedHUD() else {
      return
    }
    hud.hide(true, afterDelay: defaultDelay)
  }
  
  // MARK: - Helper
  
  func imageBundle() -> NSBundle {
    let bundle = NSBundle(forClass: self.classForCoder)
    let url = bundle.URLForResource("ProgressHUD", withExtension: "bundle")
    let imageBundle = NSBundle(URL: url!)
    return imageBundle!
  }
  
  func imageWithTintColor(image: UIImage?, tintColor: UIColor = UIColor.whiteColor()) -> UIImageView {
    let imageView = UIImageView(image: image)
    imageView.image = imageView.image!.imageWithRenderingMode(.AlwaysTemplate)
    imageView.tintColor = tintColor
    return imageView
  }
  
}