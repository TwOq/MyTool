//
//  LQTextField.h
//  button
//
//  Created by lizq on 16/7/5.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQTextField : UITextField
//占位字符串颜色
@property (strong, nonatomic) UIColor *placeholderColor;
//占位字符串字体大小
@property (strong, nonatomic) UIFont *placeholderFont;
//文本距离左边间隔
@property (assign, nonatomic) float spaceToLeft;

@end
