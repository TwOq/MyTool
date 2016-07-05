//
//  LQButton.h
//  button
//
//  Created by lizq on 16/7/4.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQButton : UIButton

//imageView 大小
@property(assign, nonatomic) CGSize imageViewSize;
//imageView y方向距离button中心点的偏移量
@property(assign, nonatomic) float imageViewOffsetY;
//titleLable y方向距离imageView的间隔
@property(assign, nonatomic) float spaceToImageView;


@end
