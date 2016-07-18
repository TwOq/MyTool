//
//  ViewController.m
//  我的工具
//
//  Created by lizq on 16/6/17.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Implementation.h"
#import "LQEmojiTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *string = @"123^";
    NSLog(@"%@",string);

    NSString *newString = string.urlEncodedString;
    NSLog(@"%@",newString);

    NSString * emojiUnicode = @"\U0001f42f";
    NSLog(@"emojiUnicode:%@",emojiUnicode);

    NSData *data = [emojiUnicode dataUsingEncoding:NSUTF8StringEncoding];
    NSString *stringem = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", stringem);

    //如果直接输入\ud83d\ude04会报错，加了转义后不会报错，但是会输出字符串\ud83d\ude04,而不是😀
    NSString * emojiUTF16 = @"\\ud83d\\ude04";
    NSLog(@"emojiUTF16:%@",emojiUTF16);
    //转换
    emojiUTF16 = [NSString stringWithCString:[emojiUTF16 cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    NSLog(@"emojiUnicode2:%@",emojiUTF16);    // Do any additional setup after loading the view, typically from a nib.


    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 100)];
    label.text = @"\U0001f42f";
    label.font = [LQEmojiTool emojiFontWithSize:40];
    [self.view addSubview:label];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
