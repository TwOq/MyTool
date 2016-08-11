//
//  LQnormalTest.m
//  我的工具
//
//  Created by lizq on 16/7/28.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IDTool.h"

@interface LQnormalTest : XCTestCase

@end

@implementation LQnormalTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testID {


    XCTAssertEqual(1, [IDTool validateIDCardNumber:@"50010219907295531"]);

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
