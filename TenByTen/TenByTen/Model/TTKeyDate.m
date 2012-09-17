//
//  TTKeyDate.m
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTKeyDate.h"

@interface TTKeyDate ()

@property (nonatomic, strong) NSString * year;
@property (nonatomic, strong) NSString * month;
@property (nonatomic, strong) NSString * day;
@property (nonatomic, strong) NSString * hour;

@end

@implementation TTKeyDate

-(id) init {
    self = [super init];
    if (self) {
        self.year = @"";
        self.month = @"";
        self.day = @"";
        self.hour = @"";
    }
    return self;
}

-(void) dealloc {
    self.year = nil;
    self.month = nil;
    self.day = nil;
    self.hour = nil;
}

-(void) setWithString: (NSString *) string {
    
    NSArray * items = [string componentsSeparatedByString:@" "];
    self.year  = [items objectAtIndex:0];
    self.month = [items objectAtIndex:1];
    self.day   = [items objectAtIndex:2];
    self.hour  = [items objectAtIndex:3];
    
}

-(NSString *) path {
    
    return [NSString stringWithFormat: @"%@/%@/%@/%@/", self.year, self.month, self.day, self.hour];
}


-(NSComparisonResult) compare: (TTKeyDate *)otherKeyDate {
    
    NSInteger selfTotalHours = 0;
    NSInteger otherTotalHours = 0;
    
    selfTotalHours += [self.hour integerValue];
    otherTotalHours += [otherKeyDate.hour integerValue];
   
    selfTotalHours += ([self.day integerValue] * 24);
    otherTotalHours += ([otherKeyDate.day integerValue] *24);
    
    selfTotalHours += ([self.month integerValue] * 24 * 30);
    otherTotalHours += ([otherKeyDate.month integerValue] * 24 * 30);
    
    selfTotalHours += ([self.year integerValue] * 24 * 30 * 12);
    otherTotalHours += ([otherKeyDate.year integerValue] * 24 * 30 * 12);


    if (selfTotalHours < otherTotalHours) {
        return NSOrderedAscending;
    }
    else if (selfTotalHours == otherTotalHours) {
        return NSOrderedSame;
    }
   return NSOrderedDescending;
}

@end

