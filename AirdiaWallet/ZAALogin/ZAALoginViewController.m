//
//  ZAALoginViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAALoginViewController.h"
#import "ZAAPasswordInputView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ZAALoginViewController ()

@property (nonatomic, strong) JHImageView *bgImageView;

@property (nonatomic, strong) JHLabel *titleLabel;

@property (nonatomic, strong) ZAAPasswordInputView *passwordView;

@property (nonatomic, strong) JHButton *cancelBtn;

@end

@implementation ZAALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
}

- (void)initSubViews {
    self.navigationController.navigationBar.hidden = YES;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self titleLabel];
    [self passwordView];
    [self cancelBtn];
    [self handleLoginType];
}

- (JHImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[JHImageView alloc] init];
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        _bgImageView.image = [UIImage imageNamed:@"login_bg"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (JHLabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[JHLabel alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, 45)];
        _titleLabel.font = kAppFont(16);
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.text = @"登录";
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
    if ([[ZZAApplication getInstance] hasPin:password]) {
        if (self.onLogin) {
            self.onLogin(YES);
        }
    }
    else {
        [self showWarningMessage:@"密码错误"];
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

- (void)handleLoginType {
    ZAALoginType loginType = [[ZZAApplication getInstance] valueOfLoginType];
    if (loginType == ZAALoginType_TouchId) {
        
    }
    if (loginType == ZAALoginType_TouchId || loginType == ZAALoginType_FaceId) {
        LAContext *context = [LAContext new];
        NSString *title = (loginType == ZAALoginType_TouchId) ? @"开启了指纹识别" : @"开启了面部识别";
        WeakSelf;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:title reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // 指纹识别成功，回主线程更新UI,弹出提示框
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf handleLogin:YES];
                });
            }
            if (error) {
                // 错误的判断chuli
                if (error.code == -2) {
                    NSLog(@"用户取消了操作");
                    // 取消操作，回主线程更新UI,弹出提示框
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf handleLogin:NO];
                    });
                } else {
                    NSLog(@"错误: %@",error);
                    // 指纹识别出现错误，回主线程更新UI,弹出提示框
                    [weakSelf handleLogin:NO];
                }
            }
        }];
    }
}

- (void)handleLogin:(BOOL)success {
    if (self.onLogin) {
        self.onLogin(success);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
