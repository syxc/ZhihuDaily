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
<<<<<<< HEAD:ZhihuDaily/Classes/ZhihuAPI.swift

=======
>>>>>>> dev:ZhihuDaily/Classes/API/ZhihuAPI.swift
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
<<<<<<< HEAD:ZhihuDaily/Classes/ZhihuAPI.swift
  static func fetchSplashScreen(resolution: SplashResolution?, callback: Callback)

=======
  func fetchSplashScreen(resolution: SplashResolution) -> Promise<Splash>
  
>>>>>>> dev:ZhihuDaily/Classes/API/ZhihuAPI.swift
  /**
   获取最新消息
   
   - returns: `Promise<NSDictionary>`
   */
<<<<<<< HEAD:ZhihuDaily/Classes/ZhihuAPI.swift
  static func fetchLatestNews()

=======
  func fetchLatestNews() -> Promise<LatestNews>
>>>>>>> dev:ZhihuDaily/Classes/API/ZhihuAPI.swift
}
