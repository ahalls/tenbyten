//
//  TTDataManager.m
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

#import "TTDataManager.h"
#import "TTTenXTenApiClient.h"
#import "TTNOtifications.h"

@interface TTDataManager ()



@end

@implementation TTDataManager

#pragma mark - Object Lifecycle
-(id) init {
    self = [super init];
    
    if (self) {
        self.apiClient  = [[TTTenXTenApiClient alloc]initWithBaseURL:
                            [NSURL URLWithString:@"http://tenbyten.org/Data/"]];
        self.currentKeyDate = [[TTKeyDate alloc]init];
        self.currentHourList = [[NSArray alloc]init];
    }
    return self;
}

-(void) dealloc {
    self.apiClient = nil;
    self.currentKeyDate = nil;
    
}


#pragma mark - Interace Methods
-(void) start {
    
    [self.apiClient getLastRun: ^(NSString * lastRun) {
        if (lastRun) {
            [self.currentKeyDate setWithString:lastRun];
            
            [self.apiClient getHourListWithDateKey: self.currentKeyDate
                                        completion: ^(NSArray * hourList) {
                      
                                            self.currentHourList = hourList;
                                            
                                            [[NSNotificationCenter defaultCenter] postNotificationName:kTTNotificationCurrentHourListChanged object:nil];
                                            
                                        }];
        }
    
    }];
}

-(void) refresh {
    [self.apiClient getLastRun: ^(NSString * lastRun) {
        if (lastRun) {
            TTKeyDate * newKeyDate = [[TTKeyDate alloc]init];
            [newKeyDate setWithString:lastRun];
            if ([newKeyDate compare:self.currentKeyDate] != NSOrderedSame) {
                [self.currentKeyDate setWithString:lastRun];
                [self.apiClient getHourListWithDateKey: self.currentKeyDate
                                            completion: ^(NSArray * hourList) {
                                                
                                                self.currentHourList = hourList;
                                                
                                                [[NSNotificationCenter defaultCenter] postNotificationName:kTTNotificationCurrentHourListChanged object:nil];
                                                
                                            }];
      
                
            }
    }
    }];
    
}


-(NSURLRequest *) requestThumbnailWithWord: (TTKeyWord *) aWord{
    return [self.apiClient requestWithMethod:@"GET"
                                        path: [NSString stringWithFormat:@"global/%@%@",
                                               self.currentKeyDate.path,
                                               [aWord thumbnailFilename]]
                                  parameters:nil];

}

-(NSURLRequest *) requestFullImageWithWord: (TTKeyWord *) aWord{
    return [self.apiClient requestWithMethod:@"GET"
                                        path: [NSString stringWithFormat:@"global/%@%@",
                                               self.currentKeyDate.path,
                                               [aWord fullFilename]]
                                  parameters:nil];
    
}


#pragma mark - Singleton class method
// Discussion of this approach
// http://stackoverflow.com/questions/2199106/thread-safe-instantiation-of-a-singleton


+(TTDataManager *)sharedManager
{
    static TTDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[TTDataManager alloc] init];
    });
    
    return _sharedManager;
}

@end
