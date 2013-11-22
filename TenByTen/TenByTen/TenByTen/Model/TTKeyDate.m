//
//  TTKeyDate.m
//  TenByTen
//
//  Copyright (c) 2012 Andrew Halls (ahalls@acm.org)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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

