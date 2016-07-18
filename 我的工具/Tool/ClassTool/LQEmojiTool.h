//
//  LQEmojiTool.h
//  我的工具
//
//  Created by lizq on 16/7/14.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LQEmojiTool : NSObject
//判断字符串是否是Emoji表情
+ (BOOL)stringContainsEmoji:(NSString *)string;

//将系统表情放大显示
+ (UIFont *)emojiFontWithSize:(float)size ;

@end
