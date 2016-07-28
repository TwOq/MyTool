//
//  LQModel.m
//  我的工具
//
//  Created by lizq on 16/7/15.
//  Copyright © 2016年 zqLee. All rights reserved.
//

#import "LQModel.h"
#import "LQDefineTool.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation LQModel



#pragma mark 公有方法

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        [self setValueForKeyWithDictionary:dictionary];
    }
    return self;
}

- (NSDictionary *)dictionaryFromModel {
    __block NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    LQWeakSelf(self)
    [[super class] propertyHandel:^(NSString *propertyName) {

        [dic setValue:[NSString stringWithFormat:@"%@", [weakself valueForKey:propertyName]] forKey:propertyName];
    }];
    return dic.mutableCopy;
}

#pragma mark NSCoding 协议方法

// 归档
- (void)encodeWithCoder:(NSCoder *)enCoder{

    LQWeakSelf(self)
    [[self class] propertyHandel:^(NSString *propertyName) {
        [enCoder encodeObject:[weakself valueForKey:propertyName] forKey:propertyName];
    }];
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{

    LQWeakSelf(self)
    [[self class] propertyHandel:^(NSString *propertyName) {
        [weakself setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
    }];
    return  self;
}

#pragma mark 私有方法

+ (void)propertyHandel:(void(^)(NSString *))block {
    unsigned int count = 0;
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        block(key);
    }
    free(ivarList);
}

- (void)setValueForKeyWithDictionary:(NSDictionary *)dictionary{

    LQWeakSelf(self)
    [[self class] propertyHandel:^(NSString *objcString) {
        id value = dictionary[objcString];
        objcString = [weakself getSetter:objcString];
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%@",value];
            objc_msgSend(weakself,NSSelectorFromString(objcString),value);
        }else if ([value isKindOfClass:[NSNull class]]){
            objc_msgSend(weakself, NSSelectorFromString(objcString),@"");
        }else{
            objc_msgSend(weakself, NSSelectorFromString(objcString),value);
        }
    }];
}

- (NSString *)getSetter:(NSString *)key {

    NSString *firstChar = [key substringWithRange:NSMakeRange(0, 1)];
    firstChar = firstChar.uppercaseString;
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:[NSString stringWithFormat:@"set%@",firstChar]];
    return [key stringByAppendingString:@":"];;
}

- (NSString *)description{

    __block NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    LQWeakSelf(self)
    [[self class] propertyHandel:^(NSString *propertyName) {
        NSString *propertyNameString = [NSString stringWithFormat:@"%@ - %@\n",propertyName,[weakself valueForKey:propertyName]];
        [descriptionString appendString:propertyNameString];
    }];
    return [descriptionString copy];
}

@end
