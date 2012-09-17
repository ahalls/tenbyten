//
//  TTHourViewCell.h
//  TenByTen
//
//  Created by Andrew Halls on 9/14/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface TTHourViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *textLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailTextLabel;
@property (nonatomic, weak) MBProgressHUD * hud;
//@property (nonatomic, weak) IBOutlet UIImageView * backgroundImageView;

@end
