//
//  ZZAApplication.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "JHObject.h"

typedef NS_ENUM(NSInteger, ZAALoginType) {
    ZAALoginType_Password = 0,
    ZAALoginType_TouchId,
    ZAALoginType_FaceId
};

@interface ZZAApplication : JHObject

+ (instancetype)getInstance;

@end

@interface ZZAApplication (ZAAPIN)

- (void)setPinKey:(NSString *)key value:(NSString *)value;

- (NSString *)valueForKey:(NSString *)key;

- (NSString *)valueFromKey:(NSString *)key;

- (void)clearPin;

- (BOOL)hasPin;

- (BOOL)hasPin:(NSString *)key;

@end

@interface ZZAApplication (ZAALoginType)

- (void)setLoginType:(ZAALoginType)value;

- (ZAALoginType)valueOfLoginType;

- (void)clearLoginType;

@end
