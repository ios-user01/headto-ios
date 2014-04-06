//
//  HTIntroViewController.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTIntroViewController.h"

@interface HTIntroViewController ()

@end

@implementation HTIntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *ipinfo = [NSURL URLWithString:@"http://ipinfo.io/json"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:ipinfo completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSLog(@"Got response %@ with error %@.\n", response, error);
//        NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                      
        NSString *city = [res valueForKey:@"city"];
        
        NSDate *date = [NSDate date];
        NSLog(@"City: %@ %@", date, city);
                                      
        NSString *searchingIn = [@"Searching venues in " stringByAppendingString:city];
        searchingIn = [searchingIn stringByAppendingString:@"."];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.currentLocationLabel.text = searchingIn;
        });
    }];
    
    [task resume];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    // get value from box
    // append to foursquare url
    // parse response
    // put venue names inside label
    
    NSString *searchQuery = self.searchField.text;
    
    NSString *foursquareSuggestCompletionURL = @"https://api.foursquare.com/v2/venues/suggestcompletion?client_id=EBA5MTZIPRVHNGKU2RB4KZ45J2BAOZFSYIXHGYBGR1KIXFIQ&client_secret=K0CBX5TQKHNEB35MGT3NNIVLWP0C4L0CQQ4UP3C2LUSLQL0W&v=20130725&limit=10&near=Bangalore&query="; //append with query;
    
    NSString *queryURL = [foursquareSuggestCompletionURL stringByAppendingString:searchQuery]; //possible problem with spaces in query
    
    NSURL *foursquareSuggestCompletionEndpoint = [NSURL URLWithString:queryURL];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:foursquareSuggestCompletionEndpoint completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // add error handling
//        NSLog(@"Got response %@ with error %@.\n", response, error);
//        NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
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

@end
