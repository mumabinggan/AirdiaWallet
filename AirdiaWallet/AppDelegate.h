//
//  AppDelegate.h
//  AirdiaWallet
//
//  Created by muma on 2018/2/2.
//  Copyright © 2018年 muma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZAANavigationController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    ZAANavigationController *_rootVC;
}

@property (strong, nonatomic) UIWindow *window;

@end

