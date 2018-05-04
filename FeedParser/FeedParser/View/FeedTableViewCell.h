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

@end
