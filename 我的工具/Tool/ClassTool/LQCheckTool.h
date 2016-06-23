//
//  LQCommon.h
//  NoCardPay
//
//  Created by lizq on 16/5/17.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LQCheckTool : NSObject

//验证是否为银行卡号
+ (BOOL)checkCardNo:(NSString*) cardNo;
//验证身份证15或者18位
+ (BOOL)checkUserIdCard:(NSString*)idCard;
//验证手机号码
+ (NSString *)checkMobileNumber:(NSString *)mobile;
//验证用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString*)password;

@end
