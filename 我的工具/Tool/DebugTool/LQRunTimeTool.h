//
//  LQRunTimeTool.h
//  我的工具
//
//  Created by lizq on 16/7/27.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQRunTimeTool : NSObject

+ (void)printClassIvars:(Class)className;
+ (void)printClassMethods:(Class)className;

@end
