//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import Alamofire


class RootViewController: BaseViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = NSLocalizedString("app_name", comment: "AppName")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: Selector("searchTap"))
    
    AppClient.instance.fetchSplashScreen(SplashResolution._1080) { (data, error) -> Void in
      if error != nil {
        print("error: \(error)")
      } else {
        if let json = data as? Dictionary<String, String> {
          print("json: \(json)")
          let splash = Splash(text: json["text"], image: json["img"])
          print(splash.image)
        }
      }
    }
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
