//
//  Feed.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"

/**
 Feed class contains the instance member of feed
 */
@interface Feed : NSObject

/**
 Title string in feed list
 */
@property (nonatomic, strong) NSString *titleString;

/**
 Description to be displayed in feed list
 */
@property (nonatomic, strong) NSString *descriptionString;

/**
 Image url that gets downloaded and while showing a list
 */
@property (nonatomic, strong) NSString *imageURLString;

/**
 Returns Feed instance instantiated from feedDictionary

 @param feedDictionary feed dictionary returned from API
 @return Feed instance
 */
- (id)initWithFeedDictionary:(NSDictionary *)feedDictionary;

@end
