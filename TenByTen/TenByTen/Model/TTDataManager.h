//
//  TTDataManager.h
//  TenByTen
//
//  Copyright (c) 2012 Andrew Halls (ahalls@acm.org)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "TTKeyDate.h"
#import "TTKeyWord.h"

#import "AFNetworking.h"

/**
 The 'TTDataManager' class provides management of the application data model.  Providing reference to in memory data structures. Manages the connection with the data source, the 10x10 server.
 */
@interface TTDataManager : NSObject

/**
 The 'currentKeyDate' is the date of the last photo news harvest that is available on the 10x10 server. 
 
 */
@property (nonatomic, strong) TTKeyDate * currentKeyDate;

/**
 The 'currentHourList' is a list of keywords from the current hour of photo news on the 10x10 server.
 */
@property (nonatomic, strong) NSArray * currentHourList;

/**
 Implements the singleton pattern returning a reference to the one and only instance of the class in the address space.
 
 @return object of TTDataManager Class.
 
 */
+(TTDataManager *)sharedManager;

/**
 Starts the dataManager  queries the 10x10 server and gathers current data.
 */
-(void) start;

/**
 Refresh the dataManager updating current state from the 10x10 server.
 
 */
-(void) refresh;

/**
 Generate the request structure for the fetch thumbnail image from the 10x10 server
 
 @param 'keyWord' specifies the specific thumbnail image to fetch
 
 @return 'NSURLRequest' used by the ApiClient to request data
 */
-(NSURLRequest *) requestThumbnailWithWord: (TTKeyWord *) keyWord;

/**
 Generate the request structure for the fetch full image from the 10x10 server
 
 @param 'keyWord' specifies the specific full image to fetch
 
 @return 'NSURLRequest' used by the ApiClient to request data
 */
-(NSURLRequest *) requestFullImageWithWord: (TTKeyWord *) keyWord;

@end
