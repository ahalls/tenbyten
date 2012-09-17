//
//  TTWordViewController.m
//  TenByTen
//
//  Created by Andrew Halls on 9/16/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTWordViewController.h"
#import "TTDataManager.h"
#import "TTWordImageView.h"
#import "MBProgressHUD.h"

@interface TTWordViewController ()

@property (nonatomic, assign) NSUInteger itemIndex;

@end

@implementation TTWordViewController {
    BOOL _firstTime;
}

- (id)initWithNibName:(NSString *)nibNameObrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameObrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _firstTime = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = self.keyWord.word;
    
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


#pragma mark - NIPagingScrollViewDataSource
- (NSInteger) numberOfPagesInPagingScrollView:		(NIPagingScrollView *) 	pagingScrollView	{
    
    return [[TTDataManager sharedManager].currentHourList count];
}

- (UIView<NIPagingScrollViewPage> *) pagingScrollView:		(NIPagingScrollView *) 	pagingScrollView
                                     pageViewForIndex:		(NSInteger) 	pageIndex {
    
    
    
    TTWordImageView * detailView = (TTWordImageView *) [pagingScrollView dequeueReusablePageWithIdentifier: @"page"];
    
    if (!detailView) {
        
        detailView = [[TTWordImageView alloc] initWithFrame: CGRectMake(0, 0, 320, 460)];
    }
    
    
    
    
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:detailView animated:YES];
    hud.graceTime = 0.5f;
    hud.opacity = 0.0;
    
    self.keyWord = [[TTDataManager sharedManager].currentHourList objectAtIndex: pageIndex];
    
    [detailView.imageView setImageWithURLRequest:
     [[TTDataManager sharedManager] requestFullImageWithWord: self.keyWord]
                                placeholderImage: nil
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             [hud hide: YES];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                             [hud hide: YES];
                                             NSLog(@"requestFullImageWithWord: %@", error);
                                         } ];
    
    
    return detailView;
}

#pragma mark - NIPagingScrollViewDelegate
- (void) pagingScrollViewDidChangePages:		(NIPagingScrollView *) 	pagingScrollView {
    if (_firstTime) {
        _firstTime = NO;
    }
    else {
        self.itemIndex = pagingScrollView.centerPageIndex;
        self.title = [[TTDataManager sharedManager].currentHourList objectAtIndex:self.itemIndex];
    }

}

@end
