//
//  ZAACreateWalletViewController.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAABaseViewController.h"

typedef NS_ENUM(NSInteger, ZAACreateFromType) {
    ZAACreateFromType_Create = 0,
    ZAACreateFromType_Import,
};

@interface ZAACreateWalletViewController : ZAABaseViewController

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *pin;

@property (nonatomic, strong) NSString *privateStr;

@property (nonatomic, assign) ZAACreateFromType fromType;

@property (nonatomic, copy) void (^onCreate)(BOOL success, NSString *pin);

@end
