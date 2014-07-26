//
//  RACExtensions.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/25/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation

// from: http://napora.org/a-swift-reaction/

struct RAC  {
    var target : NSObject!
    var keyPath : String!
    var nilValue : AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }

    
    func assignSignal(signal : RACSignal) {
        signal.setKeyPath(self.keyPath, onObject: self.target, nilValue: self.nilValue)
    }
}

operator infix <~ {}
@infix func <~ (rac: RAC, signal: RACSignal) {
    rac.assignSignal(signal)
}

operator infix ~> {}
@infix func ~> (signal: RACSignal, rac: RAC) {
    rac.assignSignal(signal)
}



