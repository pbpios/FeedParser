

//
//  BaseDataTransfer.m
//  FeedParser
//
//  Created by Prashant on 5/2/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "BaseDataTransfer.h"

@implementation BaseDataTransfer

- (id)initWithURL:(NSString *)urlString {
    self = [super init];
    if (self) {
        self.requestURL = [NSURL URLWithString:urlString];
    }

    return self;
}

- (void)sendRequest {
    BOOL isConnection = [self checkNetworkConnection];
    if (!isConnection) {
        self.networkConnectivityBlock(self, isConnection);
    }else {
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.requestURL]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *_response, NSData *_data, NSError *_error) {
                                 NSError *error;
                                 NSString *responseString = [[[[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                                 NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                 NSMutableDictionary *feedDataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];

                                 if (feedDataDictionary != nil) {
                                     self.successBlock(self, feedDataDictionary);
                                 } else {
                                     self.failureBlock(self, error);
                                 }
                               }];
    }
}


- (void)downloadImage {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      NSURLRequest *request = [NSURLRequest requestWithURL:self.requestURL];

      [NSURLConnection sendAsynchronousRequest:request
                                         queue:[NSOperationQueue new]
                             completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   self.failureBlock(self, connectionError);
                               } else {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   self.successBlock(self, image);
                               }
                             }];
    });
}


- (BOOL)checkNetworkConnection
{
    Reachability *internetReachability = [Reachability reachabilityForInternetConnection];
    [internetReachability startNotifier];

    NetworkStatus netStatus = [internetReachability currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:        {
            return NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            return YES;
            break;
        }
        case ReachableViaWiFi:        {
            return YES;
            break;
        }
    }
    return NO;
}

@end
