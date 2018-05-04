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

- (void)pullFeedWithCompletionHandler:(void (^)(FeedData *feedData, NSError *error))completionHandler withFailureBlock:(void (^) (NSError *error, BOOL isConnection))failureHandler{
    
    BaseDataTransfer *dataTransfer = [[BaseDataTransfer alloc] initWithURL:REQUEST_URL];
    [dataTransfer setSuccessBlock:^(BaseDataTransfer *dataTransfer, id responseObject) {
        if (responseObject) {
            @try {
                FeedData *feedData = [[FeedData alloc] initWithFeedDataDictionary:responseObject];
                self.feedData = feedData;
                completionHandler(feedData, nil);
            }
            @catch (NSException *exception) {
                self.feedData = nil;
                completionHandler(self.feedData, nil);
            }
        }
    }];
    
    [dataTransfer setFailureBlock:^(BaseDataTransfer *dataTransfer, NSError *error) {
        failureHandler(error,YES);
    }];
    
    [dataTransfer setNetworkConnectivityBlock:^(BaseDataTransfer *dataTransfer, BOOL isConnection) {
        if (!isConnection) {
            failureHandler(nil,isConnection);
        }
    }];
    [dataTransfer sendRequest];
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

-(void)setCellDataAtIndexPath:(NSIndexPath *)indexPath forCell:(FeedTableViewCell *)cell {
    
    Feed *feedObject = [self feedAtIndexPath:indexPath];

    [cell.feedTitleLabel setText:feedObject.titleString];
    [cell.feedDescriptionLabel setText:feedObject.descriptionString];
    [cell.feedImageView setImage:[UIImage imageNamed:@"placeholder"]];
    
    if (feedObject.imageURLString.length > 0) {
        BaseDataTransfer *dataTransfer = [[BaseDataTransfer alloc] initWithURL:feedObject.imageURLString];
        [dataTransfer setSuccessBlock:^(BaseDataTransfer *dataTransfer, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.feedImageView setImage:responseObject];
            });
        }];
        
        [dataTransfer setFailureBlock:^(BaseDataTransfer *dataTransfer, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.feedImageView setImage:[UIImage imageNamed:@"placeholder"]];
            });
        }];
        [dataTransfer downloadImage];
    }
}


@end
