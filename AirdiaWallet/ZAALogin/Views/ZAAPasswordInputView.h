//
//  ZAAPasswordInputView.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZAAView.h"

@interface ZAAPasswordInputView : ZAAView

@property (nonatomic, copy) void (^onApply)(NSString *password);

- (void)clearUpPassword;

@end
