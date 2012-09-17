//
//  TTDataManager.m
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTDataManager.h"
#import "TTTenXTenApiClient.h"
#import "TTNOtifications.h"

@interface TTDataManager ()

@property (nonatomic, strong) TTTenXTenApiClient * apiClient;

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
