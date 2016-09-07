//
//  News.swift
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

import Foundation
import ObjectMapper

/// 新闻条目
struct News {
  /// 新闻标题
  var title: String!
  
  /// 供 Google Analytics 使用
  var ga_prefix: String!
  
  /// 图像地址
  var images: [String]!
  
  var type: Int!
  
  /// url 与 share_url 中最后的数字（应为内容的 id）
  var id: Int!
  
  /// css
  var css: [String]!
  
  /// js
  var js: [String]!
  
  /// share_url
  var share_url: String!
  
  /// image_source
  var image_source: String!
  
  /// image
  var image: String!
  
  /// body
  var body: String!
  
  var description: String {
    return "Title: \(title), GA_Prefix: \(ga_prefix), Images: \(images), Type: \(type), Id: \(id)\n"
  }
}

extension News: Mappable {
  init?(_ map: Map) {}
  
  mutating func mapping(map: Map) {
    title         <- map["title"]
    ga_prefix     <- map["ga_prefix"]
    images        <- map["images"]
    type          <- map["type"]
    id            <- map["id"]
    css           <- map["css"]
    js            <- map["js"]
    share_url     <- map["share_url"]
    image_source  <- map["image_source"]
    image         <- map["image"]
    body          <- map["body"]
  }
}
