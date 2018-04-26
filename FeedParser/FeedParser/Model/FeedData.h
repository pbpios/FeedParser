//
//  FeedData.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
@interface FeedData : NSObject
@property(nonatomic, strong) NSString *navigationTitle;
@property(nonatomic, strong) NSMutableArray *feedArray;
-(id)initWithFeedDataDictionary:(NSDictionary *)feedDictionary;

@end
