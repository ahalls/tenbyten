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
    
    func executing(subject: RACSubject) {
        subject.sendNext(true)
    }
    func finished (subject: RACSubject) {
        subject.sendNext(false)
    }

    var executingSignals : NSMutableArray = []

    
    let currentDateExecuting = RACSubject()
    

    func getCurrentDate() {
        executing(currentDateExecuting)
        let requestURL = "\(serverDataPrefix)global/Now/dateString.txt"
        managerText.responseSerializer =  AFHTTPResponseSerializer()
        let request =  managerText.rac_GET(requestURL, parameters: nil)
        
        request.subscribeNext() {(responseObject:AnyObject!)  -> Void in
            if let data = responseObject as? NSData {
                //ToDo Causes error in compiler
                //var date =  data.tbt_date //    NSData_TenByTen.dateFromData(data)
                let date = NSData_TenByTen.dateFromData(data)
                self._currentDate.sendNext(date)
                self.finished(self.currentDateExecuting)
             }
        }
        request.subscribeError(){(error:NSError!) -> Void in
                println("Error: " + error!.localizedDescription)
                self._errorStatus.sendError(error)
                self.finished(self.currentDateExecuting)
        }
    
    }
    
    var _currentDate: RACSubject = RACSubject()
    var currentDate:RACSignal {
        get {
            getCurrentDate()
            return _currentDate
        }
    }

    let imageView = UIImageView();
    let currentSummaryImageExecuting = RACSubject()
    func getCurrentSummaryImage() {
        executing(currentSummaryImageExecuting)
        let requestURL = "\(serverDataPrefix)global/Now/now.jpg"
        let imageRequest = NSURLRequest( URL:  NSURL(string: requestURL))
   
        self.imageView.setImageWithURLRequest( imageRequest,
            placeholderImage: nil,
            success: {(request: NSURLRequest? ,response: NSHTTPURLResponse? ,image: UIImage?) -> Void in
              self._currentSummaryImage.sendNext(image)
              self.finished(self.currentSummaryImageExecuting)
            },
            failure: { (request: NSURLRequest?, response: NSHTTPURLResponse?, error: NSError?) -> Void in
                println("Error: " + error!.localizedDescription)
                self._errorStatus.sendError(error)
                self.finished(self.currentSummaryImageExecuting)
            })

    }
    var _currentSummaryImage: RACSubject = RACSubject()

    var currentSummaryImage:RACSignal { get {
        getCurrentSummaryImage()
        return _currentSummaryImage
    }}
    
    var _errorStatus: RACSubject = RACSubject()
    var errorStatus: RACSignal {
        get { return _errorStatus }
    }
    
    func myOR( a:Bool, _ b:Bool) -> Bool {
        return a || b
    }
    
    var _isExecuting: RACSignal?
    
    var isExecuting: RACSignal {
        get {

            if (!_isExecuting) {
                _isExecuting = RACSignal.combineLatest(executingSignals).reduceOr()
            }
            
            return _isExecuting!
            
        }
    }

    init() {
        self.executingSignals.addObject(currentDateExecuting)
        self.executingSignals.addObject(currentSummaryImageExecuting)
        finished(currentSummaryImageExecuting)
        finished(currentDateExecuting)

   }

}
