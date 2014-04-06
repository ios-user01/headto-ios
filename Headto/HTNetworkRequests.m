//
//  HTHTTPRequest.m
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import "HTNetworkRequests.h"
#import "AFNetworking.h"

@implementation HTNetworkRequests

+ (void)makeIPInfoRequest:(void (^)(NSString *city))callback
{
    NSURL *url = [NSURL URLWithString:@"http://ipinfo.io/json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //AFNetworking asynchronous url request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *city = [responseObject valueForKey:@"city"];
        
        callback(city);
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

+ (void)foursquareSuggestCompletionForQuery:(NSString *)query inCity:(NSString *)city onCompletion:(void (^)(NSArray *minivenues))callback
{
    
    NSString *url = @"https://api.foursquare.com/v2/venues/suggestcompletion";
    NSDictionary *parameters = @{
                                 @"client_id": @"EBA5MTZIPRVHNGKU2RB4KZ45J2BAOZFSYIXHGYBGR1KIXFIQ",
                                 @"client_secret": @"K0CBX5TQKHNEB35MGT3NNIVLWP0C4L0CQQ4UP3C2LUSLQL0W",
                                 @"v": @"20130725",
                                 @"limit": @"10",
                                 @"near": city,
                                 @"query": query
                                 };
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *minivenues = [[responseObject valueForKey:@"response"] valueForKey:@"minivenues"];
        
        callback(minivenues);
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
        
    }];
    
    [operation start];
    
}

@end
