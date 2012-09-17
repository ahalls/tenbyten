//
//  TTTenXTenApiClient.h
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "AFHTTPClient.h"

@class TTKeyDate;

@interface TTTenXTenApiClient : AFHTTPClient

-(void) getLastRun:(void (^)(NSString * lastRun))completion;

-(void) getHourListWithDateKey: (TTKeyDate *) keyDate completion: (void (^)(NSArray * hourList))completion;

@end 
