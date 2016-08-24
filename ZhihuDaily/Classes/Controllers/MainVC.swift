//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import PromiseKit

class MainVC: BaseTableViewController, XRCarouselViewDelegate {
  
  lazy var bannerView: XRCarouselView = {
    let bannerView = XRCarouselView()
    bannerView.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: AppConstants.HomeTopBannerHeight)
    bannerView.clipsToBounds = true
    bannerView.contentMode = .ScaleAspectFill
    bannerView.changeMode = .Default
    return bannerView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.statusBarShouldLight = true
    self.navigationItem.title = NSLocalizedString("app_name", comment: "AppName")
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(self.searchTap))
    
    self.hud.show()
    self.setupView()
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
  
  
  // MARK: Setup view
  
  func setupView() {
    bannerView.delegate = self
    bannerView.backgroundColor = UIColor.flatWhiteColor()
    bannerView.imageArray = []
  }
  
  
  // MARK: Load data
  
  func loadData() {
    let client = AppClient.shareClient
    
    firstly {
        client.fetchLatestNews()
      }.then { news -> Void in
        log.info("news=\(news.top_stories)")
        
        var imageArray: [AnyObject] = []
        var titleArray: [String] = []
        
        if let topStories = news.top_stories {
          // 添加轮播图和标题
          for topStory in topStories {
            imageArray.append(topStory.image)
            titleArray.append(topStory.title)
          }
          
          self.bannerView.imageArray = imageArray
          self.bannerView.describeArray = titleArray
          
          if imageArray.count > 0 {
            self.tableView.tableHeaderView = self.bannerView
          } else {
            self.tableView.tableHeaderView = nil
          }
          // 刷新tableView
          self.reloadData()
        }
        
      }.always {
        self.hud.dismiss()
        self.setNetworkActivityIndicatorVisible(false)
      }.error { error in
        log.error("error=\(error)")
    }
  }
  
  
  // MARK: XRCarouselViewDelegate
  
  func carouselView(carouselView: XRCarouselView!, clickImageAtIndex index: Int) {
    log.info("clickImageAtIndex=\(index)")
  }
  
  
  // MARK: Other methods
  
  func searchTap() {
    log.info("searchTap...")
  }
  
  
  // MARK: deinit
  
  deinit {
    bannerView.stopTimer()
  }
}
