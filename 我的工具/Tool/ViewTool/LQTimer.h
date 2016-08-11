//
//  LQTimer.h
//  RunloopDemo
//
//  Created by lizq on 16/7/22.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQTimer : NSObject

//定时器
+ (LQTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector repeats:(BOOL)yesOrNo;
//延迟执行
+ (void)performSelector:(SEL)aSelector target:(id)aTarget afterDelay:(NSTimeInterval)delay;
//关闭定时器
- (void)invalidate;

@end
