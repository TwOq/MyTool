//
//  LQRunTimeToolTest.m
//  我的工具
//
//  Created by lizq on 16/7/27.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LQRunTimeTool.h"

@interface LQRunTimeToolTest : XCTestCase

@end

@implementation LQRunTimeToolTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIvar {

    [LQRunTimeTool printClassIvars:[UITableView class]];

}

- (void)testMethod {

    [LQRunTimeTool printClassMethods:[UITableView class]];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
