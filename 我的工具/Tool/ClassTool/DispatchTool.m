//
//  DispatchTool.m
//  DispatchDemo
//
//  Created by lizq on 16/8/10.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "DispatchTool.h"

static DispatchTool *tool = nil;

@interface DispatchTool()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_queue_t receiveQueue;
@end

@implementation DispatchTool

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(5);
        self.receiveQueue = dispatch_queue_create("receive", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (DispatchTool *)shareDispatchTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[DispatchTool alloc] init];
    });
    return tool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

- (void)addDispatchAsync:(dispatch_queue_t)queue handleBlock:(dispatch_block_t)block {

    dispatch_async(self.receiveQueue, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(queue, ^{
            if (block) {
                block();
            }
            dispatch_semaphore_signal(self.semaphore);
        });
    });
}

#pragma mark getter or setter

- (void)setMaxConcurrentOperationCount:(int)maxConcurrentOperationCount {

    self.semaphore = dispatch_semaphore_create(maxConcurrentOperationCount);
}

@end
