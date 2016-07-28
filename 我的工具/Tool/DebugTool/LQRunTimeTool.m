//
//  LQRunTimeTool.m
//  我的工具
//
//  Created by lizq on 16/7/27.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQRunTimeTool.h"
#import <objc/runtime.h>

@implementation LQRunTimeTool

+ (void)printClassIvars:(Class)className {

    unsigned int count;
    Ivar *ivarArray = class_copyIvarList(className, &count);
    for (int i = 0; i < count; i++) {
        Ivar varKey = ivarArray[i];
        const char *name = ivar_getName(varKey);
        NSString *objcString = [NSString stringWithUTF8String:name];
        NSLog(@"%@ 属性:  %@", NSStringFromClass(className), objcString);
    }
}



+ (void)printClassMethods:(Class)className {

    unsigned int count;
    Method *ivarArray = class_copyMethodList(className, &count);
    for (int i = 0; i < count; i++) {
        Method varKey = ivarArray[i];
        SEL methodSel = method_getName(varKey);
        const char *name = sel_getName(methodSel);
        NSString *objcString = [NSString stringWithUTF8String:name];
        NSLog(@"%@ 方法:  %@", NSStringFromClass(className), objcString);
    }
}
@end
