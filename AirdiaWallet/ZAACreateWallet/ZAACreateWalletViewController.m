//
//  ZAACreateWalletViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAACreateWalletViewController.h"
#import "ZAAPasswordInputView.h"
#import "ZAALoginTypeSettingViewController.h"
#import "ZAAPrivateKeySaveViewController.h"

@interface ZAACreateWalletViewController ()

@property (nonatomic, strong) JHLabel *titleLabel;

@property (nonatomic, strong) ZAAPasswordInputView *passwordView;

@property (nonatomic, strong) JHButton *cancelBtn;

@end

@implementation ZAACreateWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)initSubViews {
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    [self titleLabel];
    [self passwordView];
    [self cancelBtn];
}

- (JHLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, 45)];
        _titleLabel.font = kAppFont(16);
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (ZAAPasswordInputView *)passwordView {
    if (!_passwordView) {
        float width = 270;
        _passwordView = [[ZAAPasswordInputView alloc] initWithFrame:CGRectMake((kDeviceWidth-width)/2, 150, width, 45)];
        _passwordView.backgroundColor = kClearColor;
        WeakSelf;
        _passwordView.onApply = ^(NSString *password) {
            [weakSelf handleApply:password];
        };
        [self.view addSubview:_passwordView];
    }
    return _passwordView;
}

- (void)handleApply:(NSString *)password {
    if ([NSString isNullOrEmpty:self.pin]) {
        ZAACreateWalletViewController *vc = [[ZAACreateWalletViewController alloc] init];
        vc.titleStr = @"再次输入PIN";
        vc.pin = password;
        vc.fromType = _fromType;
        WeakSelf;
        vc.onCreate = ^(BOOL success, NSString *pin) {
            [weakSelf handleApply];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        if ([password isEqualToString:self.pin]) {
            NSString *value = [[ZZAApplication getInstance] valueFromKey:password];
            WeakSelf;
            [[ZZAApplication getInstance] setPinKey:password value:value];
            ZAALoginTypeSettingViewController *vc = [[ZAALoginTypeSettingViewController alloc] init];
            vc.onLoginType = ^(ZAALoginType type) {
                [weakSelf handleLoginType:type];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
        else {
            [self.passwordView clearUpPassword];
        }
    }
}

- (void)handleLoginType:(ZAALoginType)type {
    if (_fromType == ZAACreateFromType_Import) {
        [self handleApply];
    }
    else {
        WeakSelf;
        ZAAPrivateKeySaveViewController *vc = [[ZAAPrivateKeySaveViewController alloc] init];
        vc.onApply = ^{
            [weakSelf handleApply];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)handleApply {
    if (self.onCreate) {
        self.onCreate(YES, nil);
    }
}

- (void)handleCreate:(BOOL)success pin:(NSString *)pin {
    if (self.onCreate) {
        self.onCreate(success, pin);
    }
}

- (JHButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[JHButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40) difRadius:JHRadiusMakeRadius(20) backgroundColor:kClearColor];
        _cancelBtn.center = CGPointMake(kDeviceWidth/2, CGRectGetMaxY(self.passwordView.frame)+40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kAppFont(15);
        [_cancelBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (void)touchCancelBtn:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
