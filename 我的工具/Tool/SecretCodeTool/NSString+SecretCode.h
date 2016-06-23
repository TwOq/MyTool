//
//  NSString+Base64.h
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SecretCode)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length;
- (NSString *)base64StringFromString:(NSString*)string;
+ (NSString *)MD5FromeString:(NSString *)string;

+ (NSString *)DESEncrypt:(NSString *)string WithKey:(NSString *)key;
+ (NSString *)DESDecrypt:(NSString *)string WithKey:(NSString *)key;

@end
