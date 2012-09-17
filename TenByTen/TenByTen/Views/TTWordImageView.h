//
//  TTWordImageView.h
//  TenByTen
//
//  Created by Andrew Halls on 9/16/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTImageView.h"
#import "NIPagingScrollViewPage.h"

@interface TTWordImageView : UIView <NIPagingScrollViewPage>

@property (nonatomic, readwrite, copy) NSString* reuseIdentifier;
@property (nonatomic, strong) TTImageView * imageView;

@end
