//
//  ScanCodeView.m
//  Code
//
//  Created by lizq on 16/4/20.
//  Copyright © 2016年 w jf. All rights reserved.
//

#import "ScanCodeView.h"
#import <AVFoundation/AVFoundation.h>
#include<objc/runtime.h>

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

@interface ScanCodeView ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureMetadataOutput *captureMetadataOutput;
@property (nonatomic, strong) CAShapeLayer *workRectLayer;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *viewpreviewLayer;

@end


@implementation ScanCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.userInteractionEnabled = YES;
        [self initDevice];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withResultBlock:(void (^)(NSString *))resultBlock{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self initDevice];
        if (resultBlock) {
            objc_setAssociatedObject(self, @"reslutBlock", resultBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
    }
    return self;
}




- (BOOL)hasCameraAuthority {
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"摄像头权限未开启，请在设置-隐私-相机中开启权限"
                                                       delegate:self
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:@"设置",nil];
        [alert show];
        return NO;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        NSLog(@"Authorized");
        
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){//点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                NSLog(@"Granted access to %@", mediaType);
            }
            else {
                NSLog(@"Not granted access to %@", mediaType);
            }
            
        }];
    }else {
        NSLog(@"Unknown authorization status");
    }
    return YES;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //跳转到相机权限设置界面
        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@",@"CAMERAS"]];
        [[UIApplication sharedApplication] openURL:setUrl];
    }

}

/**
 *  初始化并关联输入输出流
 */
- (void)initDevice{
    
    BOOL hasCameraAuthorzized = [self hasCameraAuthority];
    if (!hasCameraAuthorzized) {
        return;
    }
    
    NSError *error;
    //获取输入传感器
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@",[error localizedDescription]);
        return;
    }
    //初始化会话
    self.captureSession = [[AVCaptureSession alloc] init];
    
    //添加输入流到会话
    [self.captureSession addInput:input];
    //初始化输出流并添加到会话
    self.captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:self.captureMetadataOutput];
    //将输出流添加到子线程
    
    [self.captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(0, 0)];
    //设置可识别图形类型（二维码／条形码）
    [self.captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,
                                                        AVMetadataObjectTypeCode39Code,
                                                        AVMetadataObjectTypeCode39Mod43Code,
                                                        AVMetadataObjectTypeCode93Code,
                                                        AVMetadataObjectTypeCode128Code,
                                                        AVMetadataObjectTypeEAN13Code,
                                                        AVMetadataObjectTypeEAN8Code,
                                                        AVMetadataObjectTypeUPCECode,
                                                        AVMetadataObjectTypePDF417Code,
                                                        AVMetadataObjectTypeAztecCode,
                                                        AVMetadataObjectTypePDF417Code,nil]];
    //添加预览涂层
    self.viewpreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.viewpreviewLayer.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    self.viewpreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.viewpreviewLayer];
    
}

/**
 *  重写workRect set方法
 *
 *  @param workRect 扫描实际区域
 */
-(void)setWorkRectScare:(CGRect)workRectScare {
    
    CGRect frame = CGRectMake(workRectScare.origin.x *WIDTH,
                              workRectScare.origin.y*HEIGHT,
                              workRectScare.size.width *WIDTH - workRectScare.origin.x *WIDTH,
                              workRectScare.size.height*HEIGHT - workRectScare.origin.y*HEIGHT);

    self.captureMetadataOutput.rectOfInterest = [self.viewpreviewLayer metadataOutputRectOfInterestForRect:frame];
    
    NSLog(@"%@",NSStringFromCGRect(self.captureMetadataOutput.rectOfInterest));
    self.workRectLayer.frame = frame;
}

- (void)setWorkRectFrame:(CGRect)workRectFrame{

    self.captureMetadataOutput.rectOfInterest = [self.viewpreviewLayer metadataOutputRectOfInterestForRect:workRectFrame];
    NSLog(@"%@",NSStringFromCGRect(self.captureMetadataOutput.rectOfInterest));
    self.workRectLayer.frame = workRectFrame;

}

/**
 *  创建实际扫描区域边框
 *
 *  @return 返回边框图层
 */
-(CAShapeLayer *)workRectLayer {
    
    if (_workRectLayer == nil) {
        _workRectLayer = [CAShapeLayer layer];
        _workRectLayer.borderColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:0.5 alpha:1.0].CGColor;
        _workRectLayer.borderWidth = 1;
        _workRectLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_workRectLayer];
    }
    return  _workRectLayer;
}

/**
 *  开始扫描
 */
- (void)startScaning {
    [self.captureSession startRunning];
}

/**
 *  停止扫描
 */
- (void)stopScaning {
    [self.captureSession stopRunning];
}

#pragma mark_输出流代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil &&metadataObjects.count > 0) {
        [self stopScaning];

        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        NSString *resultString = metadataObject.stringValue;
        if (resultString == nil) {
            return;
        }
        void(^resultBock)(NSString *) = objc_getAssociatedObject(self, @"reslutBlock");

        __weak typeof (ScanCodeView *)bself = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (resultBock) {
                resultBock(resultString);
            }
            if ([bself.delegate respondsToSelector:@selector(scanCodeView:didReceivedResultString:)]) {
                [bself.delegate scanCodeView:bself didReceivedResultString:resultString];
            }

        });
    }
}

- (void)dealloc{
    
    [self stopScaning];
    self.captureSession = nil;
    self.captureMetadataOutput = nil;
    self.workRectLayer = nil;
    self.viewpreviewLayer = nil;
}

@end
