//
//  UIImageView+UpdateImage.h
//  MKNetworkKitDemo
//
//  Created by lizq on 16/5/11.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (UpdateImage)

//上传图片
- (void)handleImageUpdateFromeViewController:(UIViewController*)viewController
                                   withTitle:(NSString *)title
                                   imageName:(NSString *)name
                                  handleBlock:(void(^)(NSString *imageUrl))block;
//加载图片
- (void)requestImageWithUrlString:(NSString*)urlString handelBlock:(void(^)())block;
@end
