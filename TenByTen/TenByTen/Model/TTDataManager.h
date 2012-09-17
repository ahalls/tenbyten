//
//  TTDataManager.h
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTKeyDate.h"
#import "TTKeyWord.h"

#import "AFNetworking.h"

@interface TTDataManager : NSObject

@property (nonatomic, strong) TTKeyDate * currentKeyDate;
@property (nonatomic, strong) NSArray * currentHourList;


+(TTDataManager *)sharedManager;

-(void) start;

-(void) refresh;

-(NSURLRequest *) requestThumbnailWithWord: (TTKeyWord *) aWord;
-(NSURLRequest *) requestFullImageWithWord: (TTKeyWord *) aWord;

@end
