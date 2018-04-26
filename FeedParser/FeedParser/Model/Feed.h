//
//  Feed.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"
@interface Feed : NSObject
@property(nonatomic, strong) NSString *titleString;
@property(nonatomic, strong) NSString *descriptionString;
@property(nonatomic, strong) NSString *imageURLString;

/**
 Returns Feed instance instantiated from feedDictionary

 @param feedDictionary feed dictionary returned from API
 @return Feed instance
 */
-(id)initWithFeedDictionary:(NSDictionary *)feedDictionary;
@end
