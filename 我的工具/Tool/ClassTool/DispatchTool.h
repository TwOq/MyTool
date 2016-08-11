//
//  DispatchTool.h
//  DispatchDemo
//
//  Created by lizq on 16/8/10.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DispatchTool : NSObject

@property (nonatomic, assign) int maxConcurrentOperationCount; //默认并发数位5


+ (DispatchTool *)shareDispatchTool;

- (void)addDispatchAsync:(dispatch_queue_t)queue handleBlock:(dispatch_block_t)block;

@end
