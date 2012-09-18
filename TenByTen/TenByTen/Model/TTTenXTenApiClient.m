//
//  TTTenXTenApiClient.m
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

#import "TTTenXTenApiClient.h"
#import "TTKeyDate.h"
#import "TTKeyWord.h"

@implementation TTTenXTenApiClient


#pragma mark - Interface Methods

-(void) getLastRun:  (void (^)(NSString * lastRun))completion {
    
    [self getPath:@"global/lastRun.txt"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString * lastRun = [[NSString alloc] initWithData:responseObject
                                                         encoding:NSUTF8StringEncoding];
              completion(lastRun);

          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"getLastRun error: %@", error);
              completion(nil);
          }];
    
}

-(void) getHourListWithDateKey: (TTKeyDate *) keyDate completion: (void (^)(NSArray * hourList))completion {
   
    [self getPath:[NSString stringWithFormat:@"global/%@/words.txt", keyDate.path]
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString * body = [[NSString alloc] initWithData:responseObject
                                                         encoding:NSUTF8StringEncoding];
              NSArray * hourList = [body componentsSeparatedByString:@"\n"];
              
              NSMutableArray * wordList = [[NSMutableArray alloc] init];
              
              for (NSString * aWord in hourList) {
                  if (![aWord isEqualToString:@""]) {
                      [wordList addObject:[[TTKeyWord alloc]initWithWord:aWord]];
                  }
              }
              completion(wordList);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"getLastRun error: %@", error);
              completion(nil);
          }];

    
    
}

@end
