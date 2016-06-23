//
//  KeyboardTool.m
//  KeyboardLabel
//
//  Created by lizq on 16/6/21.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQKeyboardTool.h"

@interface LQKeyboardTool ()

@end

@implementation LQKeyboardTool

+ (void)keyboardWillShow:(NSNotification*)notification changeView:(UIView*)view {
    
    NSDictionary *dic = notification.userInfo;
    float duration = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    NSValue *value = dic[@"UIKeyboardFrameEndUserInfoKey"];
    float offsetY = [value CGRectValue].size.height;
    UIViewAnimationOptions options = [dic[@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        view.transform = CGAffineTransformMakeTranslation(0, -offsetY);
    } completion:nil];
}

+ (void)keyboardWillHide:(NSNotification*)notification changeView:(UIView*)view {
    
    NSDictionary *dic = notification.userInfo;
    float duration = [dic[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    UIViewAnimationOptions options = [dic[@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        view.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end
