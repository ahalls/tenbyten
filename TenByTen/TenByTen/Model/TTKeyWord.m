//
//  TTKeyWord.m
//  TenByTen
//
//  Created by Andrew Halls on 9/14/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTKeyWord.h"

@implementation TTKeyWord

-(id) initWithWord: (NSString *) aWord {
    self = [super init];
    if (self) {
        self.word = aWord;
        self.thumbnailImage = nil;
    }
    return self;
}

-(void) dealloc {
    self.word = nil;
    self.thumbnailImage = nil;
}

-(NSString *) fullFilename {
    
    return [NSString stringWithFormat:@"%@.jpg", self.word];

}

-(NSString *) thumbnailFilename {
    
    return [NSString stringWithFormat:@"%@2.jpg", self.word];

}




@end
