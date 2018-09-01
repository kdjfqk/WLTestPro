//
//  TestProjectTests.m
//  TestProjectTests
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/19.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BWA_HomeMaxCreditLimitGuide.h"

@interface TestProjectTests : XCTestCase

@end

@implementation TestProjectTests

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
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    BWA_HomeMaxCreditLimitGuide *guide = [[BWA_HomeMaxCreditLimitGuide alloc] init];
    [guide setDatasource:nil maskRect:CGRectMake(100, 100, 200, 80)];
    [guide showGuide];
    [guide removeGuide];
    XCTAssertFalse([BWA_HomeMaxCreditLimitGuide shouldShowGuideView]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
