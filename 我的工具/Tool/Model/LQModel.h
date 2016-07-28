//
//  LQModel.h
//  我的工具
//
//  Created by lizq on 16/7/15.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *number;

//字典转模型
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
//模型转字典
- (NSDictionary *)dictionaryFromModel;

@end
