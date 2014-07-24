//
//  NSData+TenByTen.swift
//  TenByTen
//
//  Created by Andrew Halls on 7/23/14.
//  Copyright (c) 2014 GaltSoft. All rights reserved.
//

import Foundation

extension NSData {
    var tbt_date: NSDate {

        let dateString = NSString(data: self,  encoding: NSASCIIStringEncoding)
        let fm = NSDateFormatter();
        
        // Example:      2014/07/21/05\n
        fm.dateFormat = "yyyy/MM/dd/HH\n"
        return fm.dateFromString(dateString)
    }
    
 }

// Added because above extension crashing the compiler in Beta 4
class  NSData_TenByTen {
    class func dateFromData(data: NSData) -> NSDate {
        let dateString = NSString(data: data,  encoding: NSASCIIStringEncoding)
        let fm = NSDateFormatter();
        
        // Example:      2014/07/21/05\n
        fm.dateFormat = "yyyy/MM/dd/HH\n"
        return fm.dateFromString(dateString)

    }
}
