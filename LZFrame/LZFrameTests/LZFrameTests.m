//
//  LZFrameTests.m
//  LZFrameTests
//
//  Created by comst on 15/9/25.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LZParser.h"
@interface LZFrameTests : XCTestCase

@end

@implementation LZFrameTests

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"login.xml" ofType:nil];
    NSData *JSONData = [[NSData alloc] initWithContentsOfFile:path];
    LZParser *parser = [[LZParser alloc] init];
    LZUserInfo *userinfo = [parser parseXML:JSONData];
    
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
