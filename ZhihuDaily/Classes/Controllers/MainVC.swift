//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

class MainVC: BaseTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.statusBarShouldLight = true
    self.navigationItem.title = NSLocalizedString("app_name", comment: "AppName")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.searchTap))
    
    self.hud.show()
    self.loadData()
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
  
  
  // MARK: Load data
  
  func loadData() {
    let client = AppClient.shareClient
    
    firstly {
        client.fetchSplashScreen(SplashResolution._1080)
      }.then { dict -> Void in
        log.info("dict=\(dict)")
        guard let splash = Mapper<Splash>().map(dict) else {
          return
        }
        log.info("splash=\(splash.description)")
      }.always {
        self.hud.dismiss()
      }.error { error in
        log.error("error=\(error)")
    }
    
    firstly {
        client.fetchLatestNews()
      }.then { dict -> Void in
        log.info("dict=\(dict)")
        guard let news = Mapper<LatestNews>().map(dict) else {
          return
        }
        log.info("news=\(news.description)")
      }.always {
        self.hud.dismiss()
      }.error { error in
        log.error("error=\(error)")
    }
  }
  
  
  // MARK: Other methods
  
  func searchTap() {
    log.info("searchTap...")
  }
}
