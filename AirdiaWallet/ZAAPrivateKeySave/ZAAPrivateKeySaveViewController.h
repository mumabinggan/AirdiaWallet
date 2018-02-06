//
//  ZAAPrivateKeySaveViewController.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAABaseViewController.h"

@interface ZAAPrivateKeySaveViewController : ZAABaseViewController

@property (nonatomic, strong) NSString *privateKey;

@property (nonatomic, copy) void (^onApply)();

@end
