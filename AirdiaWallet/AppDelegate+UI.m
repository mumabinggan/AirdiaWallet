//
//  AppDelegate+UI.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/2.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "AppDelegate.h"
#import "ZAANavigationController.h"
#import "ZAAMainViewController.h"
#import "ZAAOpenMainViewController.h"

@implementation AppDelegate (UI)

- (void)launchUIApplicatioin:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _rootVC = [[ZAANavigationController alloc] init];
    self.window.rootViewController = _rootVC;
    [self.window makeKeyAndVisible];
    
    /// Show welcome view
    
    /// Show launch view, waiting for base info response

    //[self initAppearance];
    
    //[self loadRootViewController:application withOptions:launchOptions];
    [self initOpenMainViewController];
}

- (void)initOpenMainViewController {
    ZAAOpenMainViewController *vc = [[ZAAOpenMainViewController alloc] init];
    [_rootVC presentViewController:vc animated:NO completion:nil];
}

- (void)loadRootViewController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
    ZAAMainViewController *mainVC = [[ZAAMainViewController alloc] init];
    [_rootVC setViewControllers:@[mainVC] animated:NO];
}

@end
