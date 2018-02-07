//
//  ZAALoginTypeSettingViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAALoginTypeSettingViewController.h"

@interface ZAALoginTypeSettingViewController ()

@property (nonatomic, strong) JHImageView *bgImageView;

@property (nonatomic, strong) JHLabel *titleLabel;

@property (nonatomic, strong) JHImageView *imageView;

@property (nonatomic, strong) JHLabel *tipsLabel;

@property (nonatomic, strong) JHButton *useBtn;

@property (nonatomic, strong) JHButton *noUseBtn;

@end

@implementation ZAALoginTypeSettingViewController

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
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(200, 45)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kAppAdaptWidth(100));
    }];
    [self.noUseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(200, 45)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.useBtn).offset(kAppAdaptWidth(50));
    }];
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
        _titleLabel.text = @"";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (JHButton *)useBtn {
    if (!_useBtn) {
        _useBtn = [[JHButton alloc] init];
        [_useBtn setBackgroundColor:kRGBA(255, 255, 255, 0.5)];
        _useBtn.layer.cornerRadius = 3;
        [_useBtn setTitle:@"启用Touch ID" forState:UIControlStateNormal];
        [_useBtn addTarget:self action:@selector(touchUseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_useBtn];
    }
    return _useBtn;
}

- (JHButton *)noUseBtn {
    if (!_noUseBtn) {
        _noUseBtn = [[JHButton alloc] init];
        [_noUseBtn setTitle:@"不启用" forState:UIControlStateNormal];
        [_noUseBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _noUseBtn.titleLabel.font = kAppFont(15);
        [_noUseBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_noUseBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_noUseBtn];
    }
    return _noUseBtn;
}

- (void)touchCancelBtn:(UIButton *)sender {
    if (self.onLoginType) {
        self.onLoginType(ZAALoginType_Password);
        [[ZZAApplication getInstance] setLoginType:ZAALoginType_Password];
    }
}

- (void)touchUseBtn:(UIButton *)sender {
    if (self.onLoginType) {
        self.onLoginType(ZAALoginType_TouchId);
        [[ZZAApplication getInstance] setLoginType:ZAALoginType_TouchId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
