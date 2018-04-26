//
//  FeedData.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "FeedData.h"
#import "Utility.h"
@implementation FeedData


-(id)initWithFeedDataDictionary:(NSDictionary *)feedDictionary {
    NSString *titleString = [Utility stringWithNonEmptyString:[feedDictionary objectForKey:@"title"]];
    self.navigationTitle = titleString;
    self.feedArray = [[NSMutableArray alloc] init];
    NSArray *feedDictionaryArray = [feedDictionary objectForKey:@"rows"];
    for (NSDictionary *feedDict in feedDictionaryArray ) {
        Feed *feedObject = [[Feed alloc] initWithFeedDictionary:feedDict];
        if (feedObject) {
            [self.feedArray addObject:feedObject];
        }
    }
    return  self;

}

@end
