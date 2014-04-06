//
//  HTIntroViewController.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTIntroViewController.h"
#import "AFNetworking.h"
#import "AFURLRequestSerialization.h"

@interface HTIntroViewController ()

@property NSString *currentCity;

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
    
    // fetch user location based on IP
    [self makeIPInfoRequest];

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
    
    NSString *searchQuery = self.searchField.text;
    
    [self makeFoursquareSuggestCompletionRequest:searchQuery];
}

#pragma mark - URL Fetches

- (void)makeIPInfoRequest
{
    NSURL *url = [NSURL URLWithString:@"http://ipinfo.io/json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *city = [responseObject valueForKey:@"city"];
        
        self.currentCity = city;

        NSDate *date = [NSDate date];
        NSLog(@"City: %@ %@", date, city);
        
        NSString *searchingIn = [@"Searching venues in " stringByAppendingString:city];
        searchingIn = [searchingIn stringByAppendingString:@"."];
        
        self.currentLocationLabel.text = searchingIn;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

- (void)makeFoursquareSuggestCompletionRequest:(NSString *)query
{
    
    NSString *url = @"https://api.foursquare.com/v2/venues/suggestcompletion";
    NSDictionary *parameters = @{
                                 @"client_id": @"EBA5MTZIPRVHNGKU2RB4KZ45J2BAOZFSYIXHGYBGR1KIXFIQ",
                                 @"client_secret": @"K0CBX5TQKHNEB35MGT3NNIVLWP0C4L0CQQ4UP3C2LUSLQL0W",
                                 @"v": @"20130725",
                                 @"limit": @"10",
                                 @"near": self.currentCity,
                                 @"query": query
                                 };
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *minivenues = [[responseObject valueForKey:@"response"] valueForKey:@"minivenues"];
        
        NSEnumerator *enumerator = [minivenues objectEnumerator];
        
        id minivenue;
        while (minivenue = [enumerator nextObject]) {
            /* code to act on each element as it is returned */
            NSLog(@"%@", [minivenue valueForKey:@"name"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

@end
