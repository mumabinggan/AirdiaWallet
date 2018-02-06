//
//  ZAALoginTypeSettingViewController.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAABaseViewController.h"

@interface ZAALoginTypeSettingViewController : ZAABaseViewController

@property (nonatomic, copy) void (^onLoginType)(ZAALoginType type);

@end
