//
//  LQDefineTool.h
//  我的工具
//
//  Created by lizq on 16/6/17.
//  Copyright © 2016年 zqLee. All rights reserved.


//屏幕尺寸
#define SCREEN_WIDTH			MIN(CGRectGetWidth([[UIScreen mainScreen] bounds]),CGRectGetHeight([[UIScreen mainScreen] bounds]))
#define SCREEN_HEIGHT           MAX(CGRectGetWidth([[UIScreen mainScreen] bounds]),CGRectGetHeight([[UIScreen mainScreen] bounds]))

//是否是Retina屏幕
#define isRetina            ([UIScreen mainScreen].scale > 1)

//手机屏幕判断
#define isIphone4sScreen     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))
#define isIphone5Screen     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))
#define isIphone6Screen     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667)))
#define isIphone6PScreen     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)))

//设备种类判断
#define isSimulator         (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define isIphone            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define isIpad              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//系统版本判断
#define isIOS7              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define isIOS8              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//当前软件版本号
#define BundleShortVersionString    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

// 设置rgb 颜色
#define COLOR_WITH_ARGB(R,G,B,A)            [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define COLOR_WITH_RGB(R,G,B)               [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1]
