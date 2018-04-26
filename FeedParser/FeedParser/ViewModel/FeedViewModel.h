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

@interface FeedViewModel : NSObject

@property(nonatomic, strong) FeedData *feedData;

-(void)pullFeedWithCompletionHandler:(void (^)(FeedData *feedData, NSError *error))completionHandler;

@end
