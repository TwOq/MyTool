//
//  LQSingleClassTest.m
//  我的工具
//
//  Created by lizq on 16/7/18.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LQSingleClass.h"

@interface LQSingleClassTest : XCTestCase

@end

@implementation LQSingleClassTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSingleClass {

    LQSingleClass *classShared = [LQSingleClass sharedInstance];
    LQSingleClass *classAlloc = [[LQSingleClass alloc] init];
    LQSingleClass *classNew = [[LQSingleClass new] init];
    //检测单例类的空间地址是否相同
    XCTAssertEqualObjects(classAlloc, classNew);
    XCTAssertEqualObjects(classShared, classAlloc);

}


@end
