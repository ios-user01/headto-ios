//
//  HTFirstViewController.m
//  Headto
//
//  Created by Param Aggarwal on 18/01/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (IBAction)query:(id)sender {
    // get value from sender
    // append to foursquare url
    // parse response
    // put venue names inside label
    
    NSLog(@"%@", sender);
    NSString *searchQuery = [sender text];
    
    NSString *foursquareSuggestCompletionURL = @"https://api.foursquare.com/v2/venues/suggestcompletion?client_id=EBA5MTZIPRVHNGKU2RB4KZ45J2BAOZFSYIXHGYBGR1KIXFIQ&client_secret=K0CBX5TQKHNEB35MGT3NNIVLWP0C4L0CQQ4UP3C2LUSLQL0W&v=20130725&limit=10&near=Bangalore&query="; //append with query;
    NSString *queryURL = [foursquareSuggestCompletionURL stringByAppendingString:searchQuery]; //possible problem with spaces in query
    
    NSURL *foursquareSuggestCompletionEndpoint = [NSURL URLWithString:queryURL];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:foursquareSuggestCompletionEndpoint
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                      NSLog(@"Got response %@ with error %@.\n", response, error);
                                      NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                      
                                      NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                      
                                      NSArray *minivenues = [[res valueForKey:@"response"] valueForKey:@"minivenues"];
                                      
                                      NSEnumerator *enumerator = [minivenues objectEnumerator];
                                      id minivenue;
                                      
                                      while (minivenue = [enumerator nextObject]) {
                                          /* code to act on each element as it is returned */
                                          NSLog(@"%@", [minivenue valueForKey:@"name"]);
                                      }
                                  }];
    
    [task resume];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
