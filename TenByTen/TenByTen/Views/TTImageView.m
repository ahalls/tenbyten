//
//  TTImageView.m
//  TenByTen
//
//  Created by Andrew Halls on 9/14/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTImageView.h"

@implementation TTImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setImage:(UIImage *)aImage {
    
    // note: aImage.size appears to be comming as pixes but being processed as points
    if (aImage) {
        NSLog(@"      image frame: %@", NSStringFromCGSize(aImage.size));
        NSLog(@"QUImageView frame: %@", NSStringFromCGRect(self.frame));
        
        [super setImage:[self imageByCropping:aImage byRect:self.bounds]];
    }
    else {
        [super setImage:aImage];
    }
}


-(UIImage *) imageByCropping: (UIImage *) image byRect: (CGRect) rect {
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    
    UIImage * result =[UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return result;
}

@end
