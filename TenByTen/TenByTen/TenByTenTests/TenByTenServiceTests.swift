//
//  TenByTenServiceTests.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/26/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation
import XCTest

class TenByTenServiceTests: XCTestCase {
    
    var service: NewsServiceProtocol = TenByTenService()
    var  isExecuting = false;
    
  
    func testCurrentDate() {
        let searchCompleteExpectation = expectationWithDescription("searchComplete")
        

        service.isExecuting.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let isExecuting = responseObject as? Bool {
                self.isExecuting = isExecuting
            }
            else {
                XCTFail("Unknow data type returned")
            }
        }
        
        var  currentDate = service.currentDate
        

        currentDate.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let date = responseObject as? NSDate {
                println("date: \(date)")

             }
            else {
                XCTFail("Unknow data type returned")
            }
           // XCTAssertTrue(self.isExecuting)
            searchCompleteExpectation.fulfill()
        }
      //  XCTAssertTrue(self.isExecuting)
        
        waitForExpectationsWithTimeout(10, handler: { error in
            
            if (!error) {
                XCTAssertFalse(self.isExecuting)
            }
            
            })
        
        
    }

    func testCurrentSummaryImage() {
        let searchCompleteExpectation = expectationWithDescription("searchComplete")
        
        
        service.isExecuting.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let isExecuting = responseObject as? Bool {
                self.isExecuting = isExecuting
            }
            else {
                XCTFail("Unknow data type returned")
            }
        }
        var  currentSummaryImage = service.currentSummaryImage
        
        
        currentSummaryImage.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let image = responseObject as? UIImage {

            }
            else {
                XCTFail("Unknow data type returned")
            }
            // XCTAssertTrue(self.isExecuting)
            searchCompleteExpectation.fulfill()
        }
         //XCTAssertTrue(self.isExecuting)
        
        waitForExpectationsWithTimeout(10, handler: { error in
            
            if (!error) {
                XCTAssertFalse(self.isExecuting)
            }
            
            })
        
        
    }
    

}
