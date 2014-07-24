//
//  TenByTenService.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/24/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation

class TenByTenService: NewsServiceProtocol {
    
    let managerText =  AFHTTPRequestOperationManager()
    let serverDataPrefix = "http://tenbyten.org/Data/"
    
    init() {
    }
    
    var _currentDate: RACSubject = RACSubject()
    
    func getCurrentDate() {
        var requestURL = "\(serverDataPrefix)global/Now/dateString.txt"
        managerText.responseSerializer =  AFHTTPResponseSerializer()
        var request =  managerText.rac_GET(requestURL, parameters: nil)
        
        request.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let data = responseObject as? NSData {
                // Causes error in compiler
                //var date =  data.tbt_date //    NSData_TenByTen.dateFromData(data)
                let date = NSData_TenByTen.dateFromData(data)
                self._currentDate.sendNext(date)
             }
            
        request.subscribeError(){(error:NSError!) -> Void in
            println("Error: " + error!.localizedDescription)
            self._errorStatus.sendNext(error);
            }
  
         
        }
    }
    
    var currentDate:RACSignal {
        get {
            getCurrentDate()
            return _currentDate
        }
    }


    var currentSummaryImage:RACSignal { get {return RACSignal() }}
    
    var _errorStatus: RACSubject = RACSubject()
    var errorStatus: RACSignal {
        get { return _errorStatus }
    }
    
    

    
}
