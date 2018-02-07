//
//  ZAAPrivateKeySaveViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/6.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAAPrivateKeySaveViewController.h"

@interface ZAAPrivateKeySaveViewController ()

@property (nonatomic, strong) JHImageView *bgImageView;

@property (nonatomic, strong) JHLabel *titleLabel;

@property (nonatomic, strong) JHTextView *textView;

@property (nonatomic, strong) JHButton *skipBtn;

@property (nonatomic, strong) JHButton *saveBtn;

@end

@implementation ZAAPrivateKeySaveViewController

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
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
        make.left.equalTo(@30);
        make.right.equalTo(@(-30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(@100);
    }];
    
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(@30);
        make.bottom.equalTo(@(-50));
    }];
    
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.right.equalTo(@(-30));
        make.bottom.equalTo(@(-50));
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
        _titleLabel.text = @"复制助记词";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (JHTextView *)textView {
    if (!_textView) {
        _textView = [[JHTextView alloc] init];
        _textView.layer.borderWidth = 2;
        _textView.layer.borderColor = kWhiteColor.CGColor;
        _textView.text = _privateKey;
        _textView.editable = NO;
        _textView.textColor = kWhiteColor;
        _textView.backgroundColor = kClearColor;
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (JHButton *)skipBtn {
    if (!_skipBtn) {
        _skipBtn = [[JHButton alloc] init];
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = kAppFont(15);
        [_skipBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(touchSkipBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_skipBtn];
    }
    return _skipBtn;
}

- (JHButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [[JHButton alloc] init];
        [_saveBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = kAppFont(15);
        [_saveBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(touchCopyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveBtn];
    }
    return _saveBtn;
}

- (void)touchSkipBtn:(UIButton *)sender {
    if (self.onApply) {
        self.onApply();
    }
}

- (void)touchCopyBtn:(UIButton *)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.textView.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
