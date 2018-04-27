//
//  Feed.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "Feed.h"

@implementation Feed

- (id)initWithFeedDictionary:(NSDictionary *)feedDictionary {

    if ([self validateDataDictionary:feedDictionary]) {
        self.titleString = [Utility stringWithNonEmptyString:[feedDictionary objectForKey:@"title"]];
        self.descriptionString = [Utility stringWithNonEmptyString:[feedDictionary objectForKey:@"description"]];
        self.imageURLString = [Utility stringWithNonEmptyString:[feedDictionary objectForKey:@"imageHref"]];

        return self;
    }
    return nil;
}

- (BOOL)validateDataDictionary:(NSDictionary *)dataDictionary {
    NSString *titleString = [Utility stringWithNonEmptyString:[dataDictionary objectForKey:@"title"]];
    NSString *descriptionString = [Utility stringWithNonEmptyString:[dataDictionary objectForKey:@"description"]];
    NSString *imageURLString = [Utility stringWithNonEmptyString:[dataDictionary objectForKey:@"imageHref"]];

    if (titleString.length > 0 || descriptionString.length > 0 || imageURLString.length > 0) {
        return YES;
    }
    return NO;
}

@end
