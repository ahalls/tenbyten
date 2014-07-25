//
//  NewsServiceProtocol.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/24/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation

protocol NewsServiceProtocol {
    var currentDate:RACSignal {  get  }
    var currentSummaryImage:RACSignal { get }
    var errorStatus:RACSignal { get }
    var isExecuting:RACSignal { get }
}
