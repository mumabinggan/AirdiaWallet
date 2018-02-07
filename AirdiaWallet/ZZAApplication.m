//
//  ZZAApplication.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZZAApplication.h"

static NSString *kPinKeyLocalSetting = @"kPinKeyLocalSetting";
static NSString *kLoginTypeKeyLocalSetting = @"kLoginTypeKeyLocalSetting";

@interface ZZAApplication ()

@property (nonatomic, strong) NSMutableDictionary *pinMDictionary;
@property (nonatomic, strong) NSMutableDictionary *loginTypeMDictionry;

@end

@implementation ZZAApplication

static ZZAApplication* _sharedInstance = nil;

+ (instancetype)getInstance {
    @synchronized([ZZAApplication class]) {
        if(!_sharedInstance) {
            _sharedInstance = [[self alloc] init];
        }
        return _sharedInstance;
    }
    return nil;
}

- (NSMutableDictionary *)pinMDictionary {
    if (!_pinMDictionary) {
        _pinMDictionary = [NSMutableDictionary dictionary];
    }
    return _pinMDictionary;
}

- (NSMutableDictionary *)loginTypeMDictionry {
    if (!_loginTypeMDictionry) {
        _loginTypeMDictionry = [NSMutableDictionary dictionary];
    }
    return _loginTypeMDictionry;
}

@end

@implementation ZZAApplication (ZAAPIN)

- (void)setPinKey:(NSString *)key value:(NSString *)value {
    [self clearPin];
    [self.pinMDictionary setValue:value forKey:key];
    [[JHLocalSettings sharedSettings] setSettings:self.pinMDictionary forKey:kPinKeyLocalSetting];
}

- (NSString *)valueForKey:(NSString *)key {
    NSDictionary *dic = [[JHLocalSettings sharedSettings] getSettingsForKey:kPinKeyLocalSetting];
    if (dic) {
        return (NSString *)[dic objectForKey:key];
    }
    return nil;
}

- (void)clearPin {
    [self.pinMDictionary removeAllObjects];
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kPinKeyLocalSetting];
}

//key convert to value
- (NSString *)valueFromKey:(NSString *)key {
    return key;
}

- (BOOL)hasPin {
    NSDictionary *dic = [[JHLocalSettings sharedSettings] getSettingsForKey:kPinKeyLocalSetting];
    return dic != nil;
}

- (BOOL)hasPin:(NSString *)key {
    NSDictionary *dic = [[JHLocalSettings sharedSettings] getSettingsForKey:kPinKeyLocalSetting];
    return ([dic objectForKey:key] != nil);
}

@end

@implementation ZZAApplication (ZAALoginType)

- (void)setLoginType:(ZAALoginType)value {
    [self clearPin];
    [self.pinMDictionary setValue:@(value) forKey:kLoginTypeKeyLocalSetting];
    [[JHLocalSettings sharedSettings] setSettings:@(value) forKey:kLoginTypeKeyLocalSetting];
}

- (ZAALoginType)valueOfLoginType {
    NSNumber *value = (NSNumber *)[[JHLocalSettings sharedSettings] getSettingsForKey:kLoginTypeKeyLocalSetting];
    if (value) {
        return value.integerValue;
    }
    return ZAALoginType_Password;
}

- (void)clearLoginType {
    [self.loginTypeMDictionry removeAllObjects];
    [[JHLocalSettings sharedSettings] removeSettingsForKey:kLoginTypeKeyLocalSetting];
}

@end
