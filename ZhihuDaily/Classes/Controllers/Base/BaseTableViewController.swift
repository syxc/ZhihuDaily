//
//  BaseTableViewController.swift
//  ZhihuDaily
//
//  Created by syxc on 16/2/22.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
  
  var statusBarShouldLight = false
  var animatedOnNavigationBar = true
  
  var hud: ProgressHUD!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Uncomment the following line to preserve selection between presentations
    self.clearsSelectionOnViewWillAppear = true
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
    // Setup ProgressHUD
    self.hud = ProgressHUD(view: self.view)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    if statusBarShouldLight {
      return UIStatusBarStyle.LightContent
    }
    return UIStatusBarStyle.Default
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
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
  
  /*
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    
    // Configure the cell...
    
    return cell
  }
  */
  
  /**
   tableView.reloadData()
   */
  func reloadData() {
    weak var weakSelf = self
    dispatch_async(dispatch_get_main_queue(), {
      weakSelf!.tableView.reloadData()
    })
  }
}
