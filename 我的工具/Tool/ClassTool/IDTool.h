//
//  IDTool.h
//  我的工具
//
//  Created by 吕强 on 16/7/28.
//  Copyright © 2016年 zqLee. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface IDTool : NSObject

//精确判断身份证号码
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;

//对中文输入和英文字符限制的问题
+ (void)judgeTheDigitalTypeJudgment:(UITextField *)textfield CN:(NSInteger)chinaT EN:(NSInteger)engT;

//判断身份证号码和性别是否一致
+ (BOOL)compareIdCardSex:(NSString*)idCard andSex:(NSNumber*)sex;

@end
