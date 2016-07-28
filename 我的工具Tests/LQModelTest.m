//
//  LQModelTest.m
//  我的工具
//
//  Created by lizq on 16/7/28.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LQModel.h"

@interface LQModelTest : XCTestCase
@property (nonatomic, strong) LQModel *model;
@end

@implementation LQModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDicToModel {

    NSDictionary *dic = @{@"name":@"xiaowang",
                          @"age" :@"20",
                          @"number":@"1234567"};

    self.model = [[LQModel alloc] initWithDictionary:dic];
    NSLog(@"%@", self.model);

}

- (void)testModelToDic {
    if (self.model == nil) {
        [self testDicToModel];
    }
    NSDictionary *dic = [self.model dictionaryFromModel];
    NSLog(@"%@", dic);


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
