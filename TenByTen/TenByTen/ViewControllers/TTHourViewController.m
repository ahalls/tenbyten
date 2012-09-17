//
//  TTHourViewController.m
//  TenByTen
//
//  Created by Andrew Halls on 9/13/12.
//  Copyright (c) 2012 GaltSoft. All rights reserved.
//

#import "TTHourViewController.h"
#import "AFNetworking.h"
#import "TTDataManager.h"
#import "TTNotifications.h"
#import "TTKeyWord.h"
#import "TTHourViewCell.h"
#import "MBProgressHUD.h"
#import "TTWordViewController.h"


@interface TTHourViewController ()

@end

@implementation TTHourViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self registerForNotifications];
    
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self unregisterForNotifications];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [[TTDataManager sharedManager].currentHourList count];
}

- (TTHourViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TTHourCell";
    TTHourViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    TTKeyWord * aWord = [[TTDataManager sharedManager].currentHourList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aWord.word;
    
    
    if (aWord.thumbnailImage) {
        cell.imageView.image = aWord.thumbnailImage;
        cell.hud = nil;
    }
    else {
        cell.hud = [MBProgressHUD showHUDAddedTo:cell.imageView animated:YES];
        cell.hud.graceTime = 0.1f;
        cell.hud.opacity = 0.0f;

        
        [cell.imageView setImageWithURLRequest:
     
            [[TTDataManager sharedManager] requestThumbnailWithWord: aWord]
                              placeholderImage: [UIImage imageNamed:@"BlankImage.png"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       aWord.thumbnailImage = image;
                                       [cell.hud hide:YES];
                                       cell.hud = nil;
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       [cell.hud hide:YES];
                                       cell.hud = nil;
                                     NSLog(@"setImageWithURLRequest: %@", error);
                                   } ];
    
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Actions

-(IBAction)refreshAction:(id)sender {
    
    [[TTDataManager sharedManager] refresh];
    
}

#pragma mark - Notifications

-(void) registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserverForName:kTTNotificationCurrentHourListChanged object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
        self.title = [TTDataManager sharedManager].currentKeyDate.path;
    }];
}

-(void) unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Seques

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"TTPushWordView"])
	{
        TTWordViewController * vc = (TTWordViewController *) segue.destinationViewController;
        
        vc.itemIndex = [self.tableView indexPathForSelectedRow].row;
         
	}
}

@end
