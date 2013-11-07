//
//  TTWordViewController.m
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

#import "TTWordViewController.h"
#import "TTDataManager.h"
#import "TTWordImageView.h"
#import "MBProgressHUD.h"

@interface TTWordViewController ()

@property (nonatomic, strong) TTKeyWord * keyWord;
//@property (nonatomic, strong) 	NIPagingScrollView * scrollView;

@end

@implementation TTWordViewController {
    BOOL _firstTime;
}

- (id)initWithNibName:(NSString *)nibNameObrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameObrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void) dealloc {
    self.scrollView = nil;
    self.keyWord = nil;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    _firstTime = YES;
    
    //self.scrollView = [[NIPagingScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.dataSource = self;
    self.scrollView.delegate = self;

    [self.view addSubview:self.scrollView];
    [self.scrollView reloadData];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self setCurrentKeyWord];
    self.scrollView.centerPageIndex = self.itemIndex;

    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);

}


-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

#pragma mark - NIPagingScrollViewDataSource
- (NSInteger) numberOfPagesInPagingScrollView:	(NIPagingScrollView *) 	pagingScrollView	{
    
    return [[TTDataManager sharedManager].currentHourList count];
}

- (UIView<NIPagingScrollViewPage> *) pagingScrollView:		(NIPagingScrollView *) 	pagingScrollView
                                     pageViewForIndex:		(NSInteger) 	pageIndex {
    
    
    
    TTWordImageView * detailView = (TTWordImageView *) [pagingScrollView dequeueReusablePageWithIdentifier: @"page"];
    
    if (!detailView) {
        
        detailView = [[TTWordImageView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width,
                                                                              self.view.frame.size.height)];

    }

    
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:detailView animated:YES];
    hud.graceTime = 0.5f;
    hud.opacity = 1.0;
    
    self.keyWord = [[TTDataManager sharedManager].currentHourList objectAtIndex: pageIndex];
    
//    [detailView.imageView setImageWithURLRequest:
//     [[TTDataManager sharedManager] requestFullImageWithWord: self.keyWord]
//                                placeholderImage: nil
//                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                             [hud hide: YES];
//                                         }
//                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//                                             [hud hide: YES];
//                                             NSLog(@"requestFullImageWithWord: %@", error);
//                                         } ];
//    
    
    return detailView;
    
    
}

#pragma mark - NIPagingScrollViewDelegate
- (void) pagingScrollViewDidChangePages:		(NIPagingScrollView *) 	pagingScrollView {
    if (_firstTime) {
        _firstTime = NO;
    }
    else {
        self.itemIndex = pagingScrollView.centerPageIndex;
        [self setCurrentKeyWord];
    }

}


#pragma mark - internal methods

-(void) setCurrentKeyWord {
    self.keyWord = [[TTDataManager sharedManager].currentHourList objectAtIndex:self.itemIndex];
    self.title = self.keyWord.word;
    
}

@end
