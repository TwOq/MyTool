//
//  UIImageView+UpdateImage.m
//  MKNetworkKitDemo
//
//  Created by lizq on 16/5/11.
//  Copyright (c) 2016年 w jf. All rights reserved.
//

#import "UIImageView+UpdateImage.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"
#import "LQActivityIndicatorView.h"

#define IMAGEBLOCK  @"handleblock"
#define IMAGENAME  @"imageName"


static UIViewController *rootViewController = nil;

@interface UIImageView ()<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,NSURLConnectionDataDelegate>

@end


@implementation UIImageView (UpdateImage)

- (void)handleImageUpdateFromeViewController:(UIViewController *)viewController withTitle:(NSString *)title imageName:(NSString *)name handleBlock:(void (^)(NSString *))block{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
    [self addGestureRecognizer:tapGesture];
    rootViewController = viewController;
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    image.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 10);
    image.image = [UIImage imageNamed:@"uploadImage"];
    image.tag = 100;
    [self addSubview:image];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame) + 5, self.frame.size.width, 25)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.tag = 120;
    [self addSubview:titleLabel];
    objc_setAssociatedObject(self,IMAGEBLOCK, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self,IMAGENAME, name, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (void)requestImageWithUrlString:(NSString *)urlString handelBlock:(void (^)())block{
    
    for (UIView *view in self.subviews) {
        if (view.tag == 100||view.tag == 120) {
            view.hidden = YES;
        }
    }
    
    LQActivityIndicatorView *progressView = [[LQActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressView.frame = CGRectMake(0, 0, 40, 40);
    progressView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    progressView.color = [UIColor blackColor];
    [self addSubview:progressView];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [progressView startAnimatingwithTitle:@"图片加载中..."];
    });
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];


    self.userInteractionEnabled = NO;
    __weak typeof (UIImageView *)bself = self;
    [self setImageWithURL:[NSURL URLWithString:urlString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    
        [progressView stopAnimating];
        [progressView removeFromSuperview];
        if (image) {
            bself.image = image;
        }else{
            for (UIView *view in bself.subviews) {
                if (view.tag == 100||view.tag == 120) {
                    view.hidden = NO;
                }
            }
        }
        
        block();
    }];

}


- (void)tapHandle:(UITapGestureRecognizer *)tapGesture{

    [rootViewController.view endEditing:YES];
    [self openSheetBtn];

    
}

#pragma mark ========= UIImagePickerControllerDelegate
- (void)openSheetBtn
{
    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"从相册上传", nil];
    menu.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [menu showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        //相机
        [self snapImage];
    }else if(buttonIndex==1){
        //相册
        [self pickImage];
    }
}

-(void)snapImage
{
    // 在ios7以上的系统下，需要判断是否开启相机隐私问题；
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"摄像头权限未开启，请在设置-隐私-相机中开启权限"
                                                           delegate:self
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:@"设置",nil];
            [alert show];
            [self camereOpen];
            
        }else{
            [self camereOpen];
        }
    }else{
        [self camereOpen];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //跳转到相机权限设置界面
        NSURL *setUrl = [NSURL URLWithString:[NSString stringWithFormat: @"prefs:root=%@",@"CAMERAS"]];
        [[UIApplication sharedApplication] openURL:setUrl];
    }
}

//打开相机
- (void)camereOpen{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机摄像头不可用"
                                                       delegate:self
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [rootViewController presentViewController:picker animated:YES completion:^{}];//进入照相界面

}

//相册
- (void)pickImage
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc] init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=self;
    ipc.allowsEditing=NO;
    [rootViewController presentViewController:ipc animated:YES completion:nil];
}

//隐藏相册
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [rootViewController dismissViewControllerAnimated:YES completion:^{}];
}

//获取图片视图
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info{
    
    UIImage *img=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if(picker.sourceType==UIImagePickerControllerSourceTypeCamera){
        img=[info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    [self performSelector:@selector(setButtonBackgroundImage:) withObject:img afterDelay:0.3];
    [rootViewController dismissViewControllerAnimated:YES completion:^{}];
}


//获取图片的data信息
- (NSData * )getDataFromImage:(UIImage *)image
{
    NSData * data = [[NSData alloc] init];
    if(UIImagePNGRepresentation(image))
    {
        //PNG格式
        data = UIImagePNGRepresentation(image);
    }
    else
    {
        //JPG格式
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    return  data ;
}

//压缩图片
- (UIImage *) imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize {
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}


- (void)setButtonBackgroundImage:(UIImage * )image
{
    
    UIImage * newImg=[self imageWithImageSimple:image scaledToSize:CGSizeMake(200, 100)];
    self.image = newImg;
    [self updateImage:newImg];
    
}


-(void)updateImage:(UIImage*)image {

    for (UIView *view in self.subviews) {
        if (view.tag == 100||view.tag == 120) {
            view.hidden = YES;
        }
    }
    
    LQActivityIndicatorView *progressView = [[LQActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    progressView.frame = CGRectMake(0, 0, 40, 40);
    progressView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    progressView.color = [UIColor blackColor];
    [self addSubview:progressView];
    [progressView startAnimatingwithTitle:@"图片上传中..."];
    self.userInteractionEnabled = NO;
    NSString *imageName = objc_getAssociatedObject(self, IMAGENAME);
    
#pragma mark_重写上传图片网络请求
//    [[HttpEngine sharedHttpEngine] postImageWithImage:image key:imageName imageName:imageName OnCompletion:^(MKNetworkRequest *completedRequest) {
//        NSDictionary *rootDic = [completedRequest responseAsJSON];
//        [progressView stopAnimating];
//        
//        self.userInteractionEnabled = YES;
//        if ([[rootDic objectForKey:@"status"] isEqualToString:@"0"]) {
//            
//           NSString *imagUrl = [rootDic objectForKey:@"imgurl"];
//           void(^block)(NSString *url) = objc_getAssociatedObject(self, IMAGEBLOCK);
//            block(imagUrl);
//            
//        }else
//        {
//
//            for (UIView *view in self.subviews) {
//                if (view.tag == 100||view.tag == 120) {
//                    view.hidden = NO;
//                }
//            }
//            self.image = [UIImage imageNamed:@""];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:rootDic[@"desc"]?rootDic[@"desc"]:@"上传图片失败,请检查网络重新上传" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }];
}

@end
