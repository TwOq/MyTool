//
//  SingleClass.m
//  我的工具
//
//  Created by lizq on 16/7/18.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQSingleClass.h"

@implementation LQSingleClass
static  LQSingleClass *instance = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        //初始化属性， 确保属性只初始化一次
        instance.numberOne = [[NSString alloc] init];
        instance.array = [[NSMutableArray alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //确保只创建一次内存空间
        instance = [super allocWithZone:zone];
    });
    return instance;
}
@end
