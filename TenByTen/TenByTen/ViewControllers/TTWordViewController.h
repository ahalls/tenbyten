//
//  TTWordViewController.h
//  TenByTen
//
//  Created by Andrew Halls on 9/16/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTKeyWord.h"
#import "NimbusPagingScrollView.h"


@interface TTWordViewController : UIViewController <NIPagingScrollViewDataSource,
                                                    NIPagingScrollViewDelegate>

@property (nonatomic, strong) TTKeyWord * keyWord;

@end
