//
//  LQActivityIndicatorView.m
//  NoCardPay
//
//  Created by lizq on 16/5/20.
//  Copyright © 2016年 tangyj. All rights reserved.
//

#import "LQActivityIndicatorView.h"

@interface LQActivityIndicatorView ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation LQActivityIndicatorView

- (void)startAnimatingwithTitle:(NSString *)title{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 100, 20)];
    self.label.center = CGPointMake(CGRectGetWidth(self.frame)/2, self.label.center.y);
    self.label.text = title;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:11];
    self.label.textColor = [UIColor lightGrayColor];
    [self addSubview:self.label];
    [self startAnimating];
}

- (void)stopAnimating {

    [self.label removeFromSuperview];
    self.label = nil;
    [super stopAnimating];
}

@end
