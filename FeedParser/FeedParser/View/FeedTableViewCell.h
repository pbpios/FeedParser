//
//  FeedTableViewCell.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"
@interface FeedTableViewCell : UITableViewCell
@property UILabel *feedTitleLabel;
@property UILabel *feedDescriptionLabel;
@property UIImageView *feedImageView;
-(void)setFeedData:(Feed *)feedDataObject;

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

@end
