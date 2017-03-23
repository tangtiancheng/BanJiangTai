//
//  AppUITests.m
//  AppUITests
//
//  Created by huangxinping on 15/11/5.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface AppUITests : XCTestCase

@end

@implementation AppUITests

- (void)setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

@end
