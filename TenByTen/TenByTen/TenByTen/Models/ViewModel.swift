//
//  ViewModel.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/23/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation

class ViewModel {
    var title: String = "TenByTen"
    var dateTitle: RACSignal? {
        get {
            return newsService?.currentDate
        }
    }
    
    var connectionErrors: RACSignal?
    var image: RACSignal? {
        get {
            return newsService?.currentSummaryImage
        }
    }
    var newsService: NewsServiceProtocol?
    
    init(newsService _newsService: NewsServiceProtocol) {
        newsService = _newsService
        
        bindToServices()
    }
    var isExecuting: RACSignal? {
        get {
            return newsService?.isExecuting
        }
    }
    
    func bindToServices() {
        
      }
}
