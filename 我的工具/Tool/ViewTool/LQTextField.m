//
//  LQTextField.m
//  button
//
//  Created by lizq on 16/7/5.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQTextField.h"
#import <objc/runtime.h>

@implementation LQTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.spaceToLeft = 0;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    if (self.placeholderFont) {
        placeholderLabel.font = self.placeholderFont;
        placeholderLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    }
    if (self.spaceToLeft != 0) {
        placeholderLabel.frame = CGRectMake(self.spaceToLeft, 0, placeholderLabel.frame.size.width, self.frame.size.height);
    }
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{

    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
    _placeholderColor = placeholderColor;

}

- (void)setSpaceToLeft:(float)spaceToLeft {

    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, spaceToLeft, self.frame.size.height)];
    spaceView.backgroundColor = self.backgroundColor;
    self.leftView = spaceView;
    self.leftViewMode = UITextFieldViewModeAlways;
    _spaceToLeft = spaceToLeft;

}


@end
