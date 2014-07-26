//
//  ViewModelTests.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/26/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation
import XCTest


class NewsServiceImpl : NewsServiceProtocol {
    var currentDate:RACSignal {  get {return RACSignal()} }
    var currentSummaryImage:RACSignal {  get {return RACSignal()} }
    var errorStatus:RACSignal {  get {return RACSignal()} }
    var isExecuting:RACSignal {  get {return RACSignal()} }

}

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel = ViewModel(newsService: NewsServiceImpl())

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTitle() {
        // This is an example of a functional test case.
        XCTAssertEqual(viewModel.title,  "TenByTen")
    }

 
}
