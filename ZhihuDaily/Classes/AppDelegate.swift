//
//  AppDelegate.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import FYLogger
import Alamofire
import PromiseKit
import ChameleonFramework

/// 应用调试状态
var appDebug: Bool {
  return DEBUG_BUILD ? true : false
}

/// 全局日志组件
let log = FYLog()

let Defaults = NSUserDefaults()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    self.setupLogger()
    
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window!.backgroundColor = UIColor.whiteColor()
    
    let mainVC = MainVC()
    let nav = FYNavigationController(rootViewController: mainVC)
    
    self.window!.rootViewController = nav
    self.window!.makeKeyAndVisible()
    
    self.setupHUD()
    self.setupLaunchView()
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }  
  
  // MARK: - Config
  
  func setupLogger() {
    log.debug = appDebug
  }
  
  func setupHUD() {
    log.info("setupHUD")
  }
  
  // MARK: - LaunchView
  
  func setupLaunchView() {
    if let imageData = Defaults[.launchImage] {
      let splashView = UIView(frame: UIScreen.mainScreen().bounds)
      
      splashView.backgroundColor = UIColor.clearColor()
      window?.windowLevel = UIWindowLevelStatusBar
      window?.addSubview(splashView)
      window?.bringSubviewToFront(splashView)
      
      let splashImageView = UIImageView(frame: splashView.bounds)
      
      if let image = UIImage(data: imageData) {
        splashImageView.image = image
        splashView.addSubview(splashImageView)
      }
      
      let labelRect = CGRect(x: 0, y: splashView.frame.height - 50, width: splashView.frame.width, height: 50)
      
      let splashTextView = UILabel(frame: labelRect)
      splashTextView.font = UIFont.systemFontOfSize(12)
      splashTextView.textColor = UIColor.flatWhiteColorDark()
      splashTextView.textAlignment = NSTextAlignment.Center
      
      if let text = Defaults[.launchText] {
        splashTextView.text = text
        splashView.addSubview(splashTextView)
      }
      
      weak var weakSelf = self
      UIView.animateWithDuration(3, delay: 0, options: .CurveEaseOut, animations: {
          splashImageView.transform = CGAffineTransformMakeScale(1.05, 1.05)
          splashView.alpha = 1
        }, completion: { _ in
          splashView.alpha = 0
          splashImageView.removeFromSuperview()
          splashTextView.removeFromSuperview()
          splashView.removeFromSuperview()
          weakSelf!.window?.windowLevel = 0.0
      })
    }
    
    self.fetchLaunchImage()
  }
  
  func fetchLaunchImage() {
    let client = AppClient.shareClient
    
    firstly {
        client.fetchSplashScreen(SplashResolution._1080)
      }.then { splash -> Void in
        log.info("splash=\(splash.description)")
        
        Defaults[.launchText] = splash.text
        
        request(.GET, splash.image!).responseData(completionHandler: { (response) in
          switch response.result {
          case .Success(let data):
            Defaults[.launchImage] = data
          case .Failure(let error):
            log.error("Fetch LaunchImage error=\(error)")
          }
        })
        
      }.always {
        log.info("Fetch LaunchImage complete")
      }.error { error in
        log.error("Fetch SplashScreen error=\(error)")
    }
  }
}

extension AppDelegate {
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    if url.scheme == fyScheme {
      log.info("url.scheme=\(url.absoluteString), url.host=\(url.host), url.path=\(url.path), url.query=\(url.query)")
      
      guard let host = url.host else {
        return false
      }
      
      guard let navigation = UIApplication.topViewController()?.navigationController else {
        return false
      }
      
      if (host == FYScheme.About.raw) {
        navigation.pushViewController(AboutVC(), animated: true)
      } else if (host == FYScheme.News_Detail.raw) {
        guard let queryDict: NSDictionary = parseQueryString(url.query!) else {
          return false
        }
        log.info("queryDict=\(queryDict)")
        let detailVC = NewsDetailVC()
        detailVC.newsID = queryDict["id"] as? String
        navigation.pushViewController(detailVC, animated: true)
      }
      
      return true
    }
    return false
  }
  
  func parseQueryString(query: String) -> NSDictionary {
    let dict = NSMutableDictionary()
    let pairs = query.componentsSeparatedByString("&")
    for pair in pairs {
      let elements = pair.componentsSeparatedByString("=")
      let key = elements[0].stringByRemovingPercentEncoding
      let val = elements[1].stringByRemovingPercentEncoding
      dict.setObject(val ?? "", forKey: key ?? "")
    }
    return dict
  }
}
