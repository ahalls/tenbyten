//
//  TTKeyDateTests.m
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTKeyDateTests.h"
#import "TTKeyDate.h"

@implementation TTKeyDateTests

- (void)testSetting
{
    TTKeyDate * date = [[TTKeyDate alloc]init];
                        
    [date setWithString:@"2012 09 06 17 Thu"];
    
    STAssertTrue([[date path] isEqualToString: @"2012/09/06/17/"], @"string in path out");
    
}


@end
