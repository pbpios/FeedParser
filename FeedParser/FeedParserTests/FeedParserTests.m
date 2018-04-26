//
//  FeedParserTests.m
//  FeedParserTests
//
//  Created by Prashant on 4/26/18.
//  Copyright © 2018 Prashant. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FeedViewModel.h"
#import "FeedTableViewCell.h"
@interface FeedParserTests : XCTestCase

@property (nonatomic, strong) FeedTableViewCell *feedTableViewCell;

@property (nonatomic, strong) FeedViewModel *feedViewModel;
@end

@implementation FeedParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.feedViewModel = [[FeedViewModel alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testFeedPullingRequest {
    [self.feedViewModel pullFeedWithCompletionHandler:^(FeedData *feedData, NSError *error) {
        XCTAssertNil(feedData,"Feed data not pulled");

        XCTAssertEqual(feedData.navigationTitle.length, 0,@"Navigation Title not fetched or parsed");
        
        XCTAssertEqual(feedData.feedArray.count, 0,@"feeds not fetched or parsed");
        
    }];
}


-(void)testDownloadImage
{
    NSString *urlString = @"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg";
    [self.feedTableViewCell downloadImageWithURL:[NSURL URLWithString:urlString] completionBlock:^(BOOL succeeded, UIImage *image) {
        XCTAssertNil(image,"Image not downloaded");
    }];
    
}


- (void)testPerformanceExample {
    [self measureBlock:^{
        [self.feedViewModel pullFeedWithCompletionHandler:^(FeedData *feedData, NSError *error) {
            
        }];
    }];
}

@end
