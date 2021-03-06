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
#import "BaseDataTransfer.h"
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
        
    } withFailureBlock:^(NSError *error, BOOL isConnection) {
        XCTAssertEqual(isConnection, NO,@"Internet connection not available");
    }];
}

- (void)testDataTransfer {
    BaseDataTransfer *dataTransfer = [[BaseDataTransfer alloc] initWithURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    [dataTransfer setSuccessBlock:^(BaseDataTransfer *dataTransfer, id responseObject) {
        if (responseObject) {
            FeedData *feedData = [[FeedData alloc] initWithFeedDataDictionary:responseObject];
            XCTAssertNil(feedData,"Feed data not downloaded and parsed");
            XCTAssertNil(feedData.feedArray,"Feed array not parsed");
        }
    }];
    
    [dataTransfer setFailureBlock:^(BaseDataTransfer *dataTransfer, NSError *error) {
        XCTAssertNotNil(error,@"Request Failed");
    }];
    
    [dataTransfer sendRequest];
}

-(void)testDownloadImage
{
    BaseDataTransfer *dataTransfer = [[BaseDataTransfer alloc] initWithURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    [dataTransfer setSuccessBlock:^(BaseDataTransfer *dataTransfer, id responseObject) {
        XCTAssertNil(responseObject,"Image not downloaded");
    }];
    
    [dataTransfer setFailureBlock:^(BaseDataTransfer *dataTransfer, NSError *error) {
        XCTAssertNotNil(error,@"Request Failed");
    }];
    
    [dataTransfer downloadImage];
}

- (void)testPerformanceExample {
    [self measureBlock:^{
        [self.feedViewModel pullFeedWithCompletionHandler:^(FeedData *feedData, NSError *error) {
            
        } withFailureBlock:^(NSError *error, BOOL isConnection) {
        
        }];
    }];
}

@end
