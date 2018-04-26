//
//  Utility.h
//  FeedParser
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Utility class is collection of generic class methods
 */
@interface Utility : NSObject
/**
 Check if String has null or nil and returns the empty string.

 @param str string param
 @return validated string
 */
+ (NSString *)stringWithNonEmptyString:(NSString *)str;

@end
