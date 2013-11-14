//
//  TTDataManagerTests.m
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


#import "Kiwi.h"

#import "TTDataManager.h"
#import "TTTenXTenApiClient.h"


SPEC_BEGIN(TTDataManagerTests)

describe(@"Singleton Tests", ^{
    it(@"should return same object", ^{
        
        TTDataManager * dm1 = [TTDataManager sharedManager];
        TTDataManager * dm2 = [TTDataManager sharedManager];
        
        [[dm1 should]equal:dm2];

        
    });
});

describe(@"Inject ApiClient Mock", ^{

        
        TTDataManager * dataManager = [TTDataManager sharedManager];
    id apiClient =[TTTenXTenApiClient mock];
        dataManager.apiClient = apiClient;
        
    it(@"start", ^{
        
        [[apiClient should] receive: @selector(getLastRun:)];
        [dataManager start];
        
    });
    
    it(@"referesh", ^{
        
        [dataManager refresh];
        
    });


});
SPEC_END


