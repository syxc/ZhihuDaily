//
//  Splash.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 * 持久化数据
 */
protocol Persistence {
  static func saveData(splash: Splash)
  static func getData() -> Splash
}

/// 启动界面图像
struct Splash {
  /// 供显示的图片版权信息
  var text: String!
  
  /// 图像的 URL
  var image: String!
  
  var description: String {
    return "Text: \(text), Image: \(image)\n"
  }
}

extension Splash: Mappable {
  init?(_ map: Map) {}
  
  mutating func mapping(map: Map) {
    text  <- map["text"]
    image <- map["img"]
  }
}

extension Splash {
  class SplashHelper: NSObject, NSCoding {
    
    var splash: Splash?
    
    init(splash: Splash) {
      self.splash = splash
      super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      guard let text = aDecoder.decodeObjectForKey("text") as? String else {
        splash = nil;
        super.init();
        return nil
      }
      
      guard let image = aDecoder.decodeObjectForKey("img") as? String else {
        splash = nil;
        super.init();
        return nil
      }
      
      splash = Splash(text: text, image: image)
      
      super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
      aCoder.encodeObject(splash!.text, forKey: "text")
      aCoder.encodeObject(splash!.image, forKey: "img")
    }
    
    class func path() -> String {
      let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
      let path = documentsPath?.stringByAppendingString("/Splash")
      return path!
    }
  }
}

extension Splash {
  static func encode(splash: Splash) {
    let splashClassObject = SplashHelper(splash: splash)
    
    NSKeyedArchiver.archiveRootObject(splashClassObject, toFile: SplashHelper.path())
  }
  
  static func decode() -> Splash? {
    let splashClassObject = NSKeyedUnarchiver.unarchiveObjectWithFile(SplashHelper.path()) as? SplashHelper
    return splashClassObject?.splash
  }
}

extension Splash: Persistence {
  static func saveData(splash: Splash) {
    self.encode(splash)
  }
  
  static func getData() -> Splash {
    return self.decode()!
  }
}
