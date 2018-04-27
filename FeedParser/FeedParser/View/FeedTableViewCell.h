//
//  FeedTableViewCell.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

/**
 TableView Cell for listing Feeds
 */
@interface FeedTableViewCell : UITableViewCell
@property UILabel *feedTitleLabel;
@property UILabel *feedDescriptionLabel;
@property UIImageView *feedImageView;

/**
 Set the Data to Cell from Feed object

 @param feedDataObject Feed object
 */
- (void)setFeedData:(Feed *)feedDataObject;

/**
 Downloads the image from url and sets to the iamge

 @param url URL string
 @param completionBlock completionBlock
 */
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
