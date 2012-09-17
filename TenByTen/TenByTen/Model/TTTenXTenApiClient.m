//
//  TTTenXTenApiClient.m
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
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
