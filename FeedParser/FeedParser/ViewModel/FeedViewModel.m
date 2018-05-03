//
//  FeedViewModel.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "FeedViewModel.h"
#import "BaseDataTransfer.h"
#define REQUEST_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@implementation FeedViewModel

- (void)pullFeedWithCompletionHandler:(void (^)(FeedData *feedData, NSError *error))completionHandler {
    
    BaseDataTransfer *dataTransfer = [[BaseDataTransfer alloc] initWithURL:REQUEST_URL];
    [dataTransfer setSuccessBlock:^(BaseDataTransfer *dataTransfer, id responseObject) {
        if (responseObject) {
            FeedData *feedData = [[FeedData alloc] initWithFeedDataDictionary:responseObject];
            self.feedData = feedData;
            completionHandler(feedData, nil);
        }
    }];
    
    [dataTransfer setFailureBlock:^(BaseDataTransfer *dataTransfer, NSError *error) {
        completionHandler(nil, error);
    }];
    
    [dataTransfer sendRequest];
    
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      NSURLSession *session = [NSURLSession sharedSession];
      NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:REQUEST_URL]
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSError *jsonError = nil;
                                                NSString *responseString = [[[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                                                NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                                                NSMutableDictionary *feedDataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];

                                                if (feedDataDictionary) {
                                                    FeedData *feedData = [[FeedData alloc] initWithFeedDataDictionary:feedDataDictionary];
                                                    self.feedData = feedData;
                                                    completionHandler(feedData, nil);
                                                } else if (jsonError) {
                                                    completionHandler(nil, jsonError);
                                                } else {
                                                    completionHandler(nil, error);
                                                }
                                              }];
      [dataTask resume];
    });
     */
}

#pragma mark - Data Source

- (NSString *)navigationTitle {
    return self.feedData.navigationTitle;
}

- (NSUInteger)numberOfFeedsinTableView {
    return [self.feedData.feedArray count];
}

- (Feed *)feedAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.feedData.feedArray count] > 0) {
        Feed *feedObject = [self.feedData.feedArray objectAtIndex:indexPath.row];
        return feedObject;
    }
    return nil;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Feed *feedObject = [self feedAtIndexPath:indexPath];
    NSString *feedTitleString = feedObject.titleString;
    UIFont *feedTitleLabelFont = [UIFont boldSystemFontOfSize:18];
    CGSize maxSize = CGSizeMake(280.0f, MAXFLOAT);
    CGRect feedTitleLabelSize = [feedTitleString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : feedTitleLabelFont } context:nil];

    NSString *descriptionString = feedObject.descriptionString;
    UIFont *descriptionLabelFont = [UIFont systemFontOfSize:16];
    CGRect descriptionLabelSize = [descriptionString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : descriptionLabelFont } context:nil];
    
    CGFloat height = descriptionLabelSize.size.height + feedTitleLabelSize.size.height + 10;
    if (height < 50) {
        return 50;
    }
    return height;
}


@end
