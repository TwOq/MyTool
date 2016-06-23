//
//  LQCommon.m
//  NoCardPay
//
//  Created by lizq on 16/5/17.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import "LQCheckTool.h"

@implementation LQCheckTool

+ (BOOL)checkCardNo:(NSString*)cardNo {
    int sum = 0;
    NSInteger len = [cardNo length];
    int i = 0;
    while (i < len) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(len - 1 - i, 1)];
        int tmpVal = [tmpString intValue];
        if (i % 2 != 0) {
            tmpVal *= 2;
            if(tmpVal>=10) {
                tmpVal -= 9;
            }
        }
        sum += tmpVal;
        i++;
    }
    if((sum % 10) == 0)
        return YES;
    else
        return NO;
}


+ (BOOL)checkUserIdCard:(NSString*)idCard{
    
    NSString *pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

+ (NSString *)checkMobileNumber:(NSString *)mobile {
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
        
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的手机号码";
        }
    }
    return nil;
}

+ (BOOL)checkPassword:(NSString*)password {
    //数字字母组合密码
//    NSString *pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,25}$";
    //只包含字母数字的密码，非必需组合
    NSString *pattern =@"^[a-zA-Z0-9]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

@end
