//
//  KeyboardTool.h
//  KeyboardLabel
//
//  Created by lizq on 16/6/21.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LQKeyboardTool : NSObject

//可实现访微信消息编辑框，随键盘上／下移   移动的view需为同一个view
+ (void)keyboardWillShow:(NSNotification*)notification changeView:(UIView*)view;
+ (void)keyboardWillHide:(NSNotification*)notification changeView:(UIView*)view;


@end
