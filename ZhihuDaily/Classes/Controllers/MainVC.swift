//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper

class MainVC: BaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.statusBarShouldLight = true
    self.navigationItem.title = NSLocalizedString("app_name", comment: "AppName")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.searchTap))
    
    self.hud.show()
    
    AppClient.instance.fetchSplashScreen(SplashResolution._1080) { (data, error) -> Void in
      if error != nil {
        log.error("ERROR: \(error)")
      } else {
        /* if let splash = Mapper<Splash>().map(data) {
          log.info("splash=\(splash.description)")
        } */
      }
    }
    
    AppClient.instance.fetchLatestNews { (data, error) -> Void in
      if error != nil {
        log.error("ERROR: \(error)")
      } else {
        guard let news = Mapper<LatestNews>().map(data) else {
          return
        }
        log.info("news=\(news.description)")
        log.info("data=\(data)")
        self.hud.dismiss()
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
    log.info("searchTap...")
  }
}
