//
//  TTHourViewCell.m
//  TenByTen
//
//  Created by Andrew Halls on 9/14/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTHourViewCell.h"
#import "MBProgressHUD.h"

@implementation TTHourViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse  {
    if (self.hud) {
        [self.hud hide:NO];
        self.hud = nil;
    }

    
    self.imageView.image = nil;
}


@end
