//
//  HTFirstViewController.m
//  Headto
//
//  Created by Param Aggarwal on 18/01/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTFirstViewController.h"

@interface HTFirstViewController ()

@end

@implementation HTFirstViewController

@synthesize labelResult;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *ipinfo = [NSURL URLWithString:@"http://ipinfo.io/json"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]
                                  dataTaskWithURL:ipinfo
                                  completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                 
//                                  NSLog(@"Got response %@ with error %@.\n", response, error);
//                                                                 NSLog(@"DATA:\n%@\nEND DATA\n", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                                                 
                                   NSDictionary *res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                   NSString *city = [res valueForKey:@"city"];
                                                                 
//                                 NSLog(@"%@", city);
                                   labelResult.text = city;
                               }];
    
    
    // TODO
    // Call Foursquare API
    // List names of places
    
    
    [task resume];

    
    //[self updateLabel];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
