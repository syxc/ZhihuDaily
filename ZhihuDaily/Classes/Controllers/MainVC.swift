//
//  RootViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import UIKit
import PromiseKit

class MainVC: BaseTableViewController {
  
  private var topStories: [TopStory]?
  private var stories: [Story]?
  
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
    // Default
    self.automaticallyAdjustsScrollViewInsets = true
    
    tableView.estimatedRowHeight = 97.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    tableView.registerClass(HomeTopBannerCell.self, forCellReuseIdentifier: "BannerCell")
    tableView.registerNib(UINib(nibName: "StoryCell", bundle: nil), forCellReuseIdentifier: "StoryCell")
  }
  
  override func mj_headerRefresh() {
    self.loadData()
  }
  
  // MARK: Load data
  
  func loadData() {
    let client = AppClient.shareClient
    
    weak var weakSelf = self
    
    firstly {
        client.fetchLatestNews()
      }.then { news -> Void in
        log.info("news=\(news.top_stories)")
        if let topStories = news.top_stories {
          weakSelf!.topStories = topStories
        }
        
        if let stories = news.stories {
          weakSelf!.stories = stories
        }
        
        weakSelf!.reloadData()
      }.always {
        self.hud.dismiss()
        self.setNetworkActivityIndicatorVisible(false)
        self.mj_endRefreshing()
      }.error { error in
        log.error("error=\(error)")
    }
  }
  
  
  // MARK: UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      guard let stories = stories else {
        return 0
      }
      return stories.count
    }
    return 1
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let bannerCell = tableView.dequeueReusableCellWithIdentifier("BannerCell", forIndexPath: indexPath) as! HomeTopBannerCell      
      bannerCell.hideSeparatorLine()
      bannerCell.setupBannerData(topStories)
      return bannerCell
    }
    
    if indexPath.section == 1 {
      let cell = tableView.dequeueReusableCellWithIdentifier("StoryCell", forIndexPath: indexPath) as! StoryCell
      cell.setupStory(stories![indexPath.row])
      return cell
    }
    
    return UITableViewCell()
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return AppConstants.HomeTopBannerHeight
    }
    return 97.0
  }
  
  
  // MARK: Other methods
  
  func searchTap() {
    log.info("searchTap...")    
    self.navigationController?.pushViewController(AboutVC(), animated: true)
  }
  
  
  // MARK: deinit
  
  deinit {
    
  }
}
