//
//  ComposeCommentTests.m
//  
//
//  Created by Lorena Calderon on 12/21/15.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ComposeCommentView.h"

@interface ComposeCommentTests : XCTestCase

@end

@implementation ComposeCommentTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testThatComposeCommentSetSetsIsWritingCommentToYesIfThereIsText {
    ComposeCommentView *testComposeCommentView = [[ComposeCommentView alloc] init];
    XCTAssertFalse(testComposeCommentView.isWritingComment, @"Should be false");
    testComposeCommentView.text = @"hello world";
    XCTAssertEqualObjects(testComposeCommentView.text, @"hello world", @"test");
    XCTAssertTrue(testComposeCommentView.isWritingComment, @"Should be true");
}

- (void)testThatComposeCommentSetSetsIsWritingCommentToNoIfThereIsNoText {
    ComposeCommentView *testComposeCommentView = [[ComposeCommentView alloc] init];
    testComposeCommentView.text = @"hello world";
    XCTAssertEqualObjects(testComposeCommentView.text, @"hello world", @"test");
    XCTAssertTrue(testComposeCommentView.isWritingComment, @"Should be true");
    testComposeCommentView.text = @"";
    XCTAssertFalse(testComposeCommentView.isWritingComment, @"Should be false");
    
    
}

@end
