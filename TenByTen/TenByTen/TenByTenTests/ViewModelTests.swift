//
//  ViewModelTests.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/26/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation
import XCTest

let testDate = NSDate.dateWithTimeIntervalSinceReferenceDate(100000)

class NewsServiceImpl : NewsServiceProtocol {
    var timer: RACSignal?
    let _currentDate = RACSubject()
    let _currentSummaryImage = RACSubject()
    init() {
        timer = RACSignal.interval(1, onScheduler: RACScheduler(priority: RACSchedulerPriorityDefault)).startWith(NSDate.date())
        
        timer?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                self._currentDate.sendNext(testDate)
            }
        }

        timer?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                self._currentDate.sendNext(UIImage())
            }
        }

    }

    var currentDate:RACSignal {  get { return _currentDate }}
    var currentSummaryImage:RACSignal {  get {return _currentSummaryImage} }
    var errorStatus:RACSignal { get {return RACSignal()} }
    var isExecuting:RACSignal {  get {return RACSignal()} }

}

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel = ViewModel(newsService: NewsServiceImpl())

    func testTitle() {
        // This is an example of a functional test case.
        XCTAssertEqual(viewModel.title,  "TenByTen")
    }

    func testCurrentDate() {
        let searchCompleteExpectation = expectationWithDescription("searchComplete")
        var once = true
        self.viewModel.dateTitle?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                XCTAssert(date == testDate)
            }
            if (once) {
                searchCompleteExpectation.fulfill()
                once = false
            }
        }
        
        waitForExpectationsWithTimeout(10, handler: { error in
            
            if (!error) {
            }
            
            })
        XCTAssert(true)

    }
    
    func testCcurrentSummaryImage() {
        let searchCompleteExpectation = expectationWithDescription("searchComplete")
        var once = true
        
        self.viewModel.dateTitle?.subscribeNext() {
            (responseObject:AnyObject!)  -> Void in
            if let image = responseObject as? UIImage {
                if (once) {
                    searchCompleteExpectation.fulfill()
                    once = false
                }

            }

        }
        
        waitForExpectationsWithTimeout(10, handler: { error in
            
            if (!error) {
            }
            
            })
        XCTAssert(true)
        
    }
}
