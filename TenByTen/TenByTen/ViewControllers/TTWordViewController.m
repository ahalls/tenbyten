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
        [self setCurrentKeyWord];
    }

}


#pragma mark - internal methods

-(void) setCurrentKeyWord {
    self.keyWord = [[TTDataManager sharedManager].currentHourList objectAtIndex:self.itemIndex];
    self.title = self.keyWord.word;
    
}

@end
