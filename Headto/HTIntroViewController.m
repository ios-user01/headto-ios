//
//  HTIntroViewController.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTIntroViewController.h"
#import "HTResultsTableViewController.h"
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

        NSLog(@"City: %@", city);
        
        self.currentCity = city;
        
        self.currentLocationLabel.text = [@"Searching venues in " stringByAppendingString:city];

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
    
    HTResultsTableViewController *destination = [segue destinationViewController];
    
    destination.searchQuery = self.searchField.text;
    
    if (self.currentCity) {
        destination.currentCity = self.currentCity;
    } else {
        destination.currentCity = @"India";
    }

}

@end
