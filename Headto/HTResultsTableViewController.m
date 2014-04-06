//
//  HTResultsTableViewController.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTResultsTableViewController.h"
#import "HTNetworkRequests.h"
#import "UIImageView+AFNetworking.h"

@interface HTResultsTableViewController ()

@property NSArray *data;

@end

@implementation HTResultsTableViewController

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
    
    self.title = @"Loading...";

    [HTNetworkRequests foursquareSuggestCompletionForQuery:self.searchQuery inCity:self.currentCity onCompletion:^(NSArray *minivenues) {
        
        self.data = minivenues;
                
        self.title = self.searchQuery;

        [self.tableView reloadData];
        
    }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"miniVenueCell" forIndexPath:indexPath];
    
    NSDictionary *minivenue = [self.data objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [minivenue valueForKey:@"name"];
    
    NSDictionary *location = [minivenue valueForKey:@"location"];
    
    cell.detailTextLabel.text = [location valueForKey:@"address"];
    
    NSArray *categories = [minivenue valueForKey:@"categories"];
    
    if ([categories count] > 0) {
        NSDictionary *category = [categories objectAtIndex:0];
        
//        NSString *categoryName = [category valueForKey:@"name"];
        
        NSDictionary *icon = [category valueForKey:@"icon"];
        
        NSString *prefix = [icon valueForKey:@"prefix"];
        NSString *suffix = [icon valueForKey:@"suffix"];
        
        NSString *imageURL = [[prefix stringByAppendingString:@"bg_88"] stringByAppendingString:suffix];
        
        [cell.imageView setImageWithURL:[NSURL URLWithString:imageURL]];
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
