//
//  LQButton.m
//  button
//
//  Created by lizq on 16/7/4.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQButton.h"

@implementation LQButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageViewOffsetY = 0;
        self.spaceToImageView = 0;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    if ( self.imageView.image && self.titleLabel.text != nil) {

        CGRect imageFrame = self.imageView.frame;
        
        if (self.imageViewSize.height != 0) {
            imageFrame = CGRectMake(0, 0, self.imageViewSize.width, self.imageViewSize.height);
            self.imageView.frame = imageFrame;
        }
        CGPoint imageCenter = self.imageView.center;
        imageCenter.x = self.frame.size.width/2;
        imageCenter.y = self.frame.size.height/2 - imageFrame.size.height/3;
        self.imageView.center = imageCenter;

        float lableHeight = CGRectGetHeight(self.titleLabel.frame);
        CGRect lableFrame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.frame.size.width, lableHeight);
        self.titleLabel.frame = lableFrame;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

        if (self.imageViewOffsetY != 0 && self.spaceToImageView == 0){
            imageCenter.y = self.frame.size.height/2 - self.imageViewOffsetY;
            self.imageView.center = imageCenter;

        }else if (self.imageViewOffsetY == 0 && self.spaceToImageView != 0){
            CGRect lableFrame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.spaceToImageView, self.frame.size.width, lableHeight);
            self.titleLabel.frame = lableFrame;

        }else if(self.imageViewOffsetY != 0 && self.spaceToImageView != 0){
            imageCenter.y = self.frame.size.height/2 - self.imageViewOffsetY;
            self.imageView.center = imageCenter;
            CGRect lableFrame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + self.spaceToImageView, self.frame.size.width, lableHeight);
            self.titleLabel.frame = lableFrame;
        }

    }

}
@end
