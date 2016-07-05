//
//  ViewController.m
//  我的工具
//
//  Created by lizq on 16/6/17.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Implementation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"123^";
    NSLog(@"%@",string);

    NSString *newString = string.urlEncodedString;
    NSLog(@"%@",newString);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
