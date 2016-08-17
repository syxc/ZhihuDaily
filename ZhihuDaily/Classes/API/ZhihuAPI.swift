//
//  ZhihuAPI.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import Foundation
import PromiseKit

/* typealias Callback = (AnyObject?, NSError?) -> Void */

protocol ZhihuAPI {
  /**
   获取启动图片信息
   
   ```
   图像分辨率接受如下格式
   - 320*432
   - 480*728
   - 720*1184
   - 1080*1776
   ```
   
   - parameter resolution: 图像分辨率
   
   - returns: `Promise<NSDictionary>`
   */
  func fetchSplashScreen(resolution: SplashResolution) -> Promise<NSDictionary>
  
  /**
   获取最新消息
   
   - returns: `Promise<NSDictionary>`
   */
  func fetchLatestNews() -> Promise<NSDictionary>
}
