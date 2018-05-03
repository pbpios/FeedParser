//
//  BaseDataTransfer.h
//  FeedParser
//
//  Created by Prashant on 5/2/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 To send the request and parse the data
 */
@interface BaseDataTransfer : NSObject

/**
 Request url string
 */
@property(nonatomic, strong) NSURL *requestURL;

/**
 calls success block once data received
 */
@property(nonatomic, copy) void (^successBlock) (BaseDataTransfer *dataTransfer, id responseObject);

/**
 Call failure block if request failed
 */
@property(nonatomic, copy) void (^failureBlock) (BaseDataTransfer *dataTransfer, NSError *error);

/**
 Sends the transfer request
 */
- (void)sendRequest;

/**
 BaseDataTransfer class init method

 @param urlString urlString
 @return return BaseDataTransfer instance
 */
- (id)initWithURL:(NSString *)urlString;
@end
