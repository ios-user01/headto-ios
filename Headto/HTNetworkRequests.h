//
//  HTHTTPRequest.h
//  Headto
//
//  Created by Param Aggarwal on 06/04/14.
//  Copyright (c) 2014 Param Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTNetworkRequests : NSObject

+ (void)makeIPInfoRequest:(void (^)(NSString *city))callback;

+ (void)foursquareSuggestCompletionFor:(NSString *)query forCity:(NSString *)city onCompletion:(void (^)(NSArray *minivenues))callback;

@end
