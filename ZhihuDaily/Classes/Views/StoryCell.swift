//
//  StoryCell.swift
//  ZhihuDaily
//
//  Created by syxc on 16/9/6.
//  Copyright © 2016年 syxc. All rights reserved.
//

import UIKit
import SDWebImage

class StoryCell: UITableViewCell {
  
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  func setupStory(story: Story) {
    guard let story: Story = story else {
      return
    }
    
    titleLabel.text = story.title
    
    let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
    }
    
    let url = NSURL(string: story.images![0])
    itemImageView.sd_setImageWithURL(url, placeholderImage: UIImage(), completed: block)
  }
  
}
