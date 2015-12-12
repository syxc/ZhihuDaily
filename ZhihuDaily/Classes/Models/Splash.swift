//
//  Splash.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit


/// 启动界面图像
class Splash: NSObject {

  /// 供显示的图片版权信息
  let text: String

  /// 图像的 URL
  let image: String

  init(text: String?, image: String?) {
    self.text = text ?? ""
    self.image = image ?? ""
  }

  override var description: String {
    return "Text: \(text), Image: \(image)\n"
  }

}
