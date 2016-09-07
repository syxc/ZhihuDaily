//
//  BaseTableViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/22.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit
import MJRefresh

class BaseTableViewController: UITableViewController {
  
  var statusBarShouldLight = true
  var animatedOnNavigationBar = true
  
  var hud: ProgressHUD!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    // Uncomment the following line to preserve selection between presentations
    self.clearsSelectionOnViewWillAppear = true
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    // Setup ProgressHUD
    self.hud = ProgressHUD(view: self.view)
    
    // Setup PullToRefresh
    self.setupPullToRefresh()
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if statusBarShouldLight {
      return .LightContent
    }
    return .Default
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let navigationController = navigationController else {
      return
    }
    
    /* Config navigationBar style */
    navigationController.navigationBar.translucent = true
    
    if statusBarShouldLight {
      navigationController.navigationBar.tintColor = UIColor.whiteColor()
      navigationController.navigationBar.barTintColor = UIColor.themeColor()
      navigationController.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    } else {
      navigationController.navigationBar.tintColor = UIColor.themeColor()
      navigationController.navigationBar.barTintColor = nil
      navigationController.navigationBar.barStyle = UIBarStyle.Default
    }
    
    if navigationController.navigationBarHidden {
      navigationController.setNavigationBarHidden(false, animated: animatedOnNavigationBar)
    }
    
    self.setNeedsStatusBarAppearanceUpdate()
  }
  
  override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
    if let navigationController = navigationController {
      guard navigationController.topViewController == self else {
        return
      }
    }
    
    super.performSegueWithIdentifier(identifier, sender: sender)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  deinit {
    tableView.dataSource = nil
    tableView.delegate = nil
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
  
  /* override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    // Configure the cell...
    return cell
  } */
  
  
  private func setupPullToRefresh() {
    tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(mj_headerRefresh))
    tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(mj_footerRefresh))
    
    tableView.mj_header.automaticallyChangeAlpha = true
    tableView.mj_footer.automaticallyChangeAlpha = true
    
    // 默认隐藏上拉加载
    tableView.mj_footer.hidden = true
    
    /* TODO: 暂不不支持 Swift 调用
     // Hide the time
     tableView.mj_header.lastUpdatedTimeLabel.hidden = true
     // Hide the status
     tableView.mj_header.stateLabel.hidden = true */
  }
  
  
  // MARK: MJRefresh
  
  /**
   下拉刷新
   */
  func mj_headerRefresh() {
    
  }
  
  /**
   上拉加载
   */
  func mj_footerRefresh() {
    
  }
  
  /**
   停止下拉刷新动画
   */
  func mj_headerEndRefreshing() {
    tableView.mj_header.endRefreshing()
  }
  
  /**
   停止上拉加载动画
   */
  func mj_footerEndRefreshing() {
    tableView.mj_footer.endRefreshing()
  }
  
  /**
   停止刷新动画
   */
  func mj_endRefreshing() {
    tableView.mj_header.endRefreshing()
    tableView.mj_footer.endRefreshing()
  }
  
  
  /**
   tableView.reloadData()
   */
  func reloadData() {
    weak var weakSelf = self
    dispatch_async(dispatch_get_main_queue(), {
      weakSelf?.tableView.reloadData()
    })
  }
}
