//
//  FeedsTableViewController.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "BaseTableViewController.h"
#import "FeedViewModel.h"
#import "FeedTableViewCell.h"
@interface FeedsTableViewController : BaseTableViewController
{
    UIRefreshControl *refreshControl;
}
@property(nonatomic, strong) FeedViewModel *feedViewModel;


- (instancetype)initWithViewModel:(FeedViewModel *)viewModel;
@end
