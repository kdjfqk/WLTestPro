//
//  TestProjectUITests.m
//  TestProjectUITests
//
//  Created by Wang,Ling(wallet-plus) on 2018/7/19.
//  Copyright © 2018年 Wang,Ling(wallet-plus). All rights reserved.
//

#import <XCTest/XCTest.h>

@interface TestProjectUITests : XCTestCase

@end

@implementation TestProjectUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Guide"]/*[[".cells.staticTexts[@\"Guide\"]",".staticTexts[@\"Guide\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *showGuideButton = app.buttons[@"Show Guide"];
    [showGuideButton tap];
    
    XCUIElement *closeGuideButton = app.buttons[@"Close Guide"];
    [closeGuideButton tap];
    [showGuideButton tap];
    [closeGuideButton tap];
    [app.navigationBars[@"Guide"].buttons[@"Back"] tap];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"Sub Sub View RemoveFromSuperView Test"]/*[[".cells.staticTexts[@\"Sub Sub View RemoveFromSuperView Test\"]",".staticTexts[@\"Sub Sub View RemoveFromSuperView Test\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Sub Sub View RemoveFromSuperView Test"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element tap];
    [app.navigationBars[@"Sub Sub View RemoveFromSuperView Test"].buttons[@"Back"] tap];
    
    
}

@end
