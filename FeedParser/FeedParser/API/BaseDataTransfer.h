//
//  BaseDataTransfer.h
//  FeedParser
//
//  Created by Prashant on 5/2/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BaseDataTransfer : NSObject

@property(nonatomic, strong) NSURL *requestURL;

@property(nonatomic, copy) void (^successBlock) (BaseDataTransfer *dataTransfer, id responseObject);
@property(nonatomic, copy) void (^failureBlock) (BaseDataTransfer *dataTransfer, NSError *error);

-(void)sendRequest;
-(id)initWithURL:(NSString *)urlString;
-(void)downloadImage;
@end
