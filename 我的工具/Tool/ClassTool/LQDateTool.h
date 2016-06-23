//
//  LQDateTool.h
//  我的工具
//
//  Created by lizq on 16/6/17.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQDateTool : NSObject
//根据时间戳获取带格式的时间
+ (NSString *)getFormatTimeFromString:(NSString *)timeString;
//获取年月日
+ (NSUInteger)getDay;
+ (NSUInteger)getMonth;
+ (NSUInteger)getYear;
+ (int )getHour;
+ (int )getMinute;
+ (int)getSecond;

@end
