//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper
import SVProgressHUD

class RootViewController: BaseViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.statusBarShouldLight = true
    self.navigationItem.title = NSLocalizedString("app_name", comment: "AppName")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchTap"))
    
    AppClient.instance.fetchSplashScreen(SplashResolution._1080) { (data, error) -> Void in
      if error != nil {
        print("ERROR: \(error)")
      } else {
        if let splash = Mapper<Splash>().map(data) {
          print("splash=\(splash.description)")
        }
      }
    }
    
    AppClient.instance.fetchLatestNews { (data, error) -> Void in
      if error != nil {
        print("ERROR: \(error)")
      } else {
        if let json = data as? Dictionary<String, AnyObject> {
          print("JSON: \(json)")
          if let news = Mapper<LatestNews>().map(data) {
            print("news=\(news.description)")
            SVProgressHUD.showInfoWithStatus(news.stories?.first?.title)
          }
        }
      }
    }
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return super.preferredStatusBarStyle()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: Other methods
  
  func searchTap() {
    print("searchTap...")
  }
}
