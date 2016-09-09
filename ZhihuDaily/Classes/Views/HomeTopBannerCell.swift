//
//  HomeTopBannerCell.swift
//  ZhihuDaily
//
//  Copyright (c) 2016年 syxc
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class HomeTopBannerCell: UITableViewCell, XRCarouselViewDelegate {
  
  lazy var bannerView: XRCarouselView = {
    let bannerView = XRCarouselView()
    bannerView.clipsToBounds = true
    bannerView.contentMode = .ScaleAspectFill
    bannerView.changeMode = .Default
    bannerView.backgroundColor = UIColor.flatWhiteColor()
    return bannerView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    bannerView.frame = self.contentView.bounds
  }
  
  deinit {
    log.info("HomeTopBannerCell deinit")
    bannerView.stopTimer()
    bannerView.delegate = nil
  }
  
  
  func setupView() {
    bannerView.delegate = self
    self.contentView.addSubview(bannerView)
  }
  
  /**
   初始化轮播图数据
   
   - parameter topStories: 轮播图数据
   */
  func setupBannerData(topStories: [TopStory]?) {
    guard let topStories = topStories else {
      return
    }
    
    var imageArray: [AnyObject] = []
    var titleArray: [String] = []
    // 添加轮播图和标题
    for topStory in topStories {
      imageArray.append(topStory.image!)
      titleArray.append(topStory.title!)
    }
    
    bannerView.imageArray = imageArray
    bannerView.describeArray = titleArray
  }
  
  
  // MARK: XRCarouselViewDelegate
  
  func carouselView(carouselView: XRCarouselView!, clickImageAtIndex index: Int) {
    log.info("clickImageAtIndex=\(index)")
  }
}
