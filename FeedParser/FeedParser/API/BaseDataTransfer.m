//
//  BaseDataTransfer.m
//  FeedParser
//
//  Created by Prashant on 5/2/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import "BaseDataTransfer.h"

@implementation BaseDataTransfer

-(id)initWithURL:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.requestURL = [NSURL URLWithString:urlString];
    }
    
    return self;
}


-(void)sendRequest {
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:self.requestURL] queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *_response, NSData *_data, NSError *_error) {
                               NSError *error;
                               NSString *responseString = [[[[NSString alloc] initWithData:_data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
                               NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                               NSMutableDictionary *feedDataDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];

                               
                               if (feedDataDictionary != nil) {
                                   self.successBlock(self, feedDataDictionary);
                               }
                               else {
                                   self.failureBlock(self, error);
                               }
                           }];
}

@end
