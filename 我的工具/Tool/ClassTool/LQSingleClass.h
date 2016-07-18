//
//  SingleClass.h
//  我的工具
//
//  Created by lizq on 16/7/18.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSingleClass : NSObject

@property (nonatomic, copy) NSString *numberOne;
@property (nonatomic, strong) NSMutableArray *array;
+ (instancetype)sharedInstance;
@end
