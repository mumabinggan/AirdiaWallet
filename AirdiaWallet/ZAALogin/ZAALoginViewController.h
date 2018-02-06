//
//  ZAALoginViewController.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAABaseViewController.h"

@interface ZAALoginViewController : ZAABaseViewController

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, copy) void (^onLogin)(BOOL success);

@end
