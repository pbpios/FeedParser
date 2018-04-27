//
//  BaseTableViewController.h
//  FeedParser
//
//  Created by Prashant on 4/27/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 BaseTableViewController for having a common features we can inherit in derived classes
 */
@interface BaseTableViewController : UITableViewController {
    UIActivityIndicatorView *loadingIndicator;
}

/**
 Shows loading indicator on screen
 */
- (void)showLoadingView;

/**
 Hides loading indicator
 */
- (void)hideLoadingView;

@end
