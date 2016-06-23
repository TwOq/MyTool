//
//  TradeKeyboard.h
//  NoCardPay
//
//  Created by lizq on 16/5/11.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import <UIKit/UIKit.h>

//自定义键盘
@interface TradeKeyboard : UIView
@property (nonatomic, strong) UILabel *delegate;
@property (nonatomic,strong) NSString *showContent;
@property (nonatomic, strong) NSString *currentContent;
@property (nonatomic, copy) BOOL (^judge)();

@end
