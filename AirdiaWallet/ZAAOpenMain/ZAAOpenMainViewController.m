//
//  ZAAOpenMainViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/2.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAAOpenMainViewController.h"

@interface ZAAOpenMainViewController ()
{
    UIImageView *_bgImageView;
    UIButton *_loginBtn;
    UIButton *_createBtn;
    UIButton *_importWalletBtn;
}
@end

@implementation ZAAOpenMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)initSubViews {
    
    _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgImageView.image = [UIImage imageNamed:@"open_main_bg"];
    [self.view addSubview:_bgImageView];
    
    CGRect frame = CGRectMake((kDeviceWidth-200)/2, kDeviceHeight-250, 200, 45);
    _loginBtn = [self createBtn:frame title:@"登录"];
    [self.view addSubview:_loginBtn];
    
    frame.origin.y += 70;
    _createBtn = [self createBtn:frame title:@"创建"];
    [self.view addSubview:_createBtn];
    
    frame.origin.y += 70;
    _importWalletBtn = [self createBtn:frame title:@"Import Wallet"];
    [self.view addSubview:_importWalletBtn];
}

- (JHButton *)createBtn:(CGRect)frame title:(NSString *)title {
    JHButton *btn = [[JHButton alloc] initWithFrame:frame difRadius:JHRadiusMakeRadius(3) backgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
