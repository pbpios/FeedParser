//
//  FeedData.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
/**
 Feed Data class has the list of feeds and navigation title string
 */
@interface FeedData : NSObject

/**
 Navigation Title string
 */
@property (nonatomic, strong) NSString *navigationTitle;

/**
 Feed list
 */
@property (nonatomic, strong) NSMutableArray *feedArray;

/**
 Create instance of FeedData with provided NSDictionary

 @param feedDictionary Feed dictionary instance received from API
 @return FeedData instances
 */
- (id)initWithFeedDataDictionary:(NSDictionary *)feedDictionary;

@end
