//
//  ScanCodeView.h
//  Code
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 w jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanCodeProtocol;

@interface ScanCodeView : UIView

@property (assign, nonatomic) id<ScanCodeProtocol>delegate;
//设置实际扫描区域(左，上，下，右) eg:CGRectMake(0.1, 0.1, 0.9, 0.9)  默认为CGRectMake(0, 0,1, 1)  
@property (assign, nonatomic) CGRect workRectScare;
//设置实际扫描区域frame
@property (assign, nonatomic) CGRect workRectFrame;

//block方法初始化
-(instancetype)initWithFrame:(CGRect)frame withResultBlock:(void(^)(NSString *))resultBlock;
//开始扫描
- (void)startScaning;
//停止扫描
- (void)stopScaning;
@end

@protocol ScanCodeProtocol <NSObject>
//扫描结果回调
-(void)scanCodeView:(ScanCodeView *)scanView didReceivedResultString:(NSString*)resultString;

@end
