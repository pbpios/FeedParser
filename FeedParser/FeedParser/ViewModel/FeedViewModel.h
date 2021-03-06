//
//  FeedViewModel.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "FeedData.h"
#import <UIKit/UIkit.h>
#import "FeedTableViewCell.h"
#import "BaseDataTransfer.h"

/**
 View model class to get the data from transfer and parse it. Sends the parsed data to controller
 */
@interface FeedViewModel : NSObject

@property (nonatomic, strong) FeedData *feedData;

/**
 Pull the data from feed URL and parse it

 @param completionHandler completionHandler
 @param failureHandler failureHandler
 */
- (void)pullFeedWithCompletionHandler:(void (^)(FeedData *feedData, NSError *error))completionHandler withFailureBlock:(void (^) (NSError *error, BOOL isConnection))failureHandler;

/**
 Returns Feed object at index from array

 @param indexPath indexPath
 @return Feed object
 */
- (Feed *)feedAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns number of Feed to be displayed in Table View

 @return return Feed count
 */
- (NSUInteger)numberOfFeedsinTableView;

/**
 Returns Navigation Title

 @return return Navigation Title
 */
- (NSString *)navigationTitle;

/**
 Calculates the height for invidual FeedTableViewCell.

 @param indexPath FeedTableViewCell indexPath
 @return Height for cell with respect to it content
 */
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;


/**
 Sets the data to cell and download image

 @param indexPath indexPath
 @param cell cell instance
 */
-(void)setCellDataAtIndexPath:(NSIndexPath *)indexPath forCell:(FeedTableViewCell *)cell;

@end
