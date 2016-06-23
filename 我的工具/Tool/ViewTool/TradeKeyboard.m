//
//  TradeKeyboard.m
//  NoCardPay
//
//  Created by lizq on 16/5/11.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import "TradeKeyboard.h"
#import "UIImage+Implementation.h"
#import "UIColor+hex.h"
#define NumPhoneArray @[@"7", @"8", @"9", @"4", @"5", @"6", @"1", @"2", @"3", @"0", @".", @"←"]

@interface TradeKeyboard ()
@property (nonatomic, strong) NSMutableArray *buttons;

@end
@implementation TradeKeyboard

/**
 *  初始化键盘
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.currentContent = @"0";
        self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
        [self setupKeyBoardButton];
    }
    return self;
}
- (NSMutableArray *)buttons
{
    if (_buttons == nil)
    {
        self.buttons = [NSMutableArray array];
    }
    return _buttons;
}

/**
 *  初始化键盘按钮
 */
- (void)setupKeyBoardButton
{
    
    float space = 2;
    float buttonWidth = (self.frame.size.width - space*2)/3;
    float buttonHeight = (self.frame.size.height - space*3)/4;
    UIView *background = [[UIView alloc] initWithFrame:self.bounds];
    for (int i = 0; i < 12; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake((buttonWidth + space)*(i%3), (buttonHeight + space)*(i/3), buttonWidth, buttonHeight);
        [button setTitle:NumPhoneArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#e3e3e3"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:10]];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        [self.buttons addObject:button];
        [background addSubview:button];
        
        if (i < 11) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
            label.text = NumPhoneArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:40];
            if (i == 10) {
                label.font = [UIFont systemFontOfSize:40];
                label.text = @"·";
            }
            label.textColor = [UIColor colorWithHexString:@"#555555"];
            [button addSubview:label];

        }else{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 15)];
            imageView.center = CGPointMake(buttonWidth/2, buttonHeight/2);
            imageView.image = [UIImage imageNamed:@"backspace"];
            [button addSubview:imageView];
        }
        
        
    }
    [self addSubview:background];
}
#pragma mark- 输入方法
- (void)buttonClick:(UIButton *)button
{
    //避免小数点重复判断
    if ([button.titleLabel.text isEqualToString:@"."]) {
        
        NSRange range = [self.currentContent rangeOfString:@"."];
        if (range.location != NSNotFound) return;
    }
    
    if ([self.currentContent rangeOfString:@"."].location != NSNotFound) {
        NSArray *contentArr = [self.currentContent componentsSeparatedByString:@"."];
        NSString *str = [contentArr objectAtIndex:1];
        if (str && str.length == 2) {
            if (!([button.titleLabel.text isEqualToString:@"←"])) {
                if ([str isEqualToString:@"00"]) {
                    self.currentContent = [self.currentContent stringByReplacingCharactersInRange:NSMakeRange(self.currentContent.length - 1, 1) withString:button.titleLabel.text];
                    self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
                    [self.delegate setText:self.showContent];
                }
                return;
            }
        }
    }
    
    //显示框为0时进行特殊处理
    if ([self.currentContent isEqualToString:@"0"]) {
        if ([button.titleLabel.text isEqualToString:@"←"]) {
            self.currentContent = @"0";
            self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
            [self.delegate setText:self.showContent];
            return;
        }
        else if ([button.titleLabel.text isEqualToString:@"."]) {
            self.currentContent = @"0.";
            self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
            [self.delegate setText:self.showContent];
            return;
        }
        else if([button.titleLabel.text isEqualToString:@"0"]) return;
        else {
            if (self.judge())
            {
                self.currentContent = [self.currentContent stringByAppendingString:button.titleLabel.text];
                self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
                [self.delegate setText:self.showContent];
            }
            return;
        }
    }
    
    if ([button.titleLabel.text isEqualToString:@"←"])
    {
        if (self.currentContent.length <= 1) {
            self.currentContent = @"0";
        }
        else {
            NSString *numString = [self.currentContent substringWithRange:NSMakeRange(self.currentContent.length - 1, 1)];
            if ([numString isEqualToString:@"."]) {
                self.currentContent = [self.currentContent stringByReplacingCharactersInRange:NSMakeRange(self.currentContent.length - 2, 2) withString:@""];
            }else{
                self.currentContent = [self.currentContent stringByReplacingCharactersInRange:NSMakeRange(self.currentContent.length - 1, 1) withString:@""];
            }
        }
        self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
        [self.delegate setText:self.showContent];
    }
    else
    {
        if (self.judge())
        {
            self.currentContent = [self.currentContent stringByAppendingString:button.titleLabel.text];
            
            self.showContent = [NSString stringWithFormat:@"¥ %.2lf",[self.currentContent doubleValue]*1.00];
            [self.delegate setText:self.showContent];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
