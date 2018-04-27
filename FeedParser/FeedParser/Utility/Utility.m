//
//  Utility.m
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString *)stringWithNonEmptyString:(NSString *)str {
    if ([str isKindOfClass:[NSNull class]] || [str isEqualToString:@""] || [str isEqual:NULL] || [str isEqualToString:@"(null)"] || str == nil || [str isEqualToString:@"<null>"]) {
        return @"";
    }
    return str;
}

@end
