//
//  FeedViewModel.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "FeedViewModel.h"
#define REQUEST_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@implementation FeedViewModel


-(void)pullFeedWithCompletionHandler:(void (^)(FeedData *feedData, NSError *error))completionHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:REQUEST_URL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSError *jsonError = nil;
            NSString *responseString = [[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
            NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *feedDataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
            
            if (feedDataDictionary) {
                FeedData *feedData = [[FeedData alloc] initWithFeedDataDictionary:feedDataDictionary];
                self.feedData = feedData;
                completionHandler(feedData,nil);
            }else if (jsonError) {
                completionHandler(nil,jsonError);
            }
            else{
                completionHandler(nil,error);
            }
        }];
        [dataTask resume];
    });
}

@end
