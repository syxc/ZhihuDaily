//
//  ZhihuDailyTests.swift
//  ZhihuDailyTests
//
//  Created by syxc on 15/12/5.
//  Copyright © 2015年 syxc. All rights reserved.
//

import XCTest
@testable import ZhihuDaily

class ZhihuDailyTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measureBlock {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testScheme() {
    let string0 = scheme(FYScheme.News_Detail)
    print("\n------ string0=\(string0) ------\n")
    
    let string1 = scheme(FYScheme.News_Detail, params: nil)
    print("\n------ string1=\(string1) ------\n")
    
    let string2 = scheme(FYScheme.News_Detail, params: ["id" : "1234"])
    print("\n------ string2=\(string2) ------\n")
    
    let string3 = scheme(FYScheme.News_Detail, params: ["id" : "1234", "content" : "abc123"])
    print("\n------ string3=\(string3) ------\n")
    
    assert(string0 == "fyzhihudaily://news_detail")
    assert(string0 == string1)
    assert(string2 == "fyzhihudaily://news_detail?id=1234")
    assert(string3 == "fyzhihudaily://news_detail?id=1234&content=abc123")
  }
}
