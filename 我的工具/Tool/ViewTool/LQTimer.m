//
//  LQTimer.m
//  RunloopDemo
//
//  Created by lizq on 16/7/22.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQTimer.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString *const TIMERKEY = @"LQTimerKey";
/*
 如果系统报错:  Too many arguments to function call, expected 0, have 3
 解决方法:选中项目 - Project - Build Settings - Preprocessing - ENABLE_STRICT_OBJC_MSGSEND  将其设置为 NO 即可
 */

@implementation LQTimer

+ (LQTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo {

    LQTimer *timerObject = [[LQTimer alloc] init];
    [self associatedTimer:timerObject WithTimeInterval:time target:aTarget selector:aSelector repeats:yesOrNo];
    return timerObject;
}

+ (void)performSelector:(SEL)aSelector target:(id)aTarget afterDelay:(NSTimeInterval)delay{

    [self associatedTimer:aTarget WithTimeInterval:delay target:aTarget selector:aSelector repeats:NO];
}

+ (void)associatedTimer:(id)object WithTimeInterval:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo {
    // get the queue
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // creat timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 参数：when 表示延迟时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    // 时间间隔设置
    uint64_t interver = (uint64_t)(time * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, start, interver, 0.0);

    __weak typeof(aTarget) weakSelf = aTarget;
    dispatch_source_set_event_handler(timer, ^{
        objc_msgSend(weakSelf, aSelector);
        if (!yesOrNo) {
            dispatch_source_cancel(timer);
        }
    });
    if ([object isKindOfClass:[LQTimer class]]) {
        objc_setAssociatedObject(object, (__bridge const void *)(TIMERKEY), timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    dispatch_resume(timer);
}

- (void)invalidate {
    dispatch_source_t timer = objc_getAssociatedObject(self, (__bridge const void *)(TIMERKEY));
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

- (void)dealloc {
    dispatch_source_t timer = objc_getAssociatedObject(self, (__bridge const void *)(TIMERKEY));
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

@end
