//
//  TTWordImageView.m
//  TenByTen
//
//  Created by Andrew Halls on 9/16/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTWordImageView.h"

@implementation TTWordImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView = [[TTImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];

    }
    return self;
}

@end
