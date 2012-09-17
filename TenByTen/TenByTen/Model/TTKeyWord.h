//
//  TTKeyWord.h
//  TenByTen
//
//  Created by Andrew Halls on 9/14/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTKeyWord : NSObject

@property (nonatomic, strong) NSString * word;
@property (nonatomic, strong) UIImage * thumbnailImage;

-(id) initWithWord: (NSString *) aWord;

-(NSString *) fullFilename;
-(NSString *) thumbnailFilename;

@end
