//
//  TTKeyDate.h
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

#import <Foundation/Foundation.h>

/**
 The 'TTKeyDate' represents dates from the 10x10 server.
 */
@interface TTKeyDate : NSObject

/**
 Sets the value of the keyDate object from the input from the 10x10 server.
 
 @param 'string' input for the date in the format of 'YYYY MM DD HH DDD'
 
 */
-(void) setWithString: (NSString *) string;

/**
 Returns the path on the 10x10 server of the data associated with the keyDate
 
 @return 'path' on the 10x10 server
 */
-(NSString *) path;

/**
 Compares two TTKeyDate returning compare result
 
 @param 'otherKeyDate' date to compare target with
 
 @return 'NSComparisonResult' returns result of the comparison values: NSOrderedAscending, NSOrderedSame,
 NSOrderedDescending
 */
-(NSComparisonResult) compare: (TTKeyDate *)otherKeyDate;

@end
