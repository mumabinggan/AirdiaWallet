//
//  ZAALoginViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAALoginViewController.h"
#import "ZAAPasswordInputView.h"

@interface ZAALoginViewController ()

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
