//
//  TTKeyDate.h
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTKeyDate : NSObject

-(void) setWithString: (NSString *) string;
-(NSString *) path;
-(NSComparisonResult) compare: (TTKeyDate *)otherKeyDate;

@end
