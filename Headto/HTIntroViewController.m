//
//  HTIntroViewController.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTIntroViewController.h"
#import "HTNetworkRequests.h"

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
    [HTNetworkRequests makeIPInfoRequest:^(NSString *city) {
        self.currentCity = city;
        
        NSDate *date = [NSDate date];
        NSLog(@"City: %@ %@", date, city);
        
        NSString *searchingIn = [@"Searching venues in " stringByAppendingString:city];
        searchingIn = [searchingIn stringByAppendingString:@"."];
        
        self.currentLocationLabel.text = searchingIn;

    }];

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
    
    [HTNetworkRequests  foursquareSuggestCompletionFor:searchQuery forCity:self.currentCity onCompletion:^(NSArray *minivenues) {
       
        NSEnumerator *enumerator = [minivenues objectEnumerator];
        
        id minivenue;
        while (minivenue = [enumerator nextObject]) {
            /* code to act on each element as it is returned */
            NSLog(@"%@", [minivenue valueForKey:@"name"]);
        }

    }];
}

@end
