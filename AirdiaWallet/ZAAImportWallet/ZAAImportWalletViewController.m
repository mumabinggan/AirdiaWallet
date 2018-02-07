//
//  ZAAImportWalletViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAAImportWalletViewController.h"
#import "ZAACreateWalletViewController.h"

@interface ZAAImportWalletViewController ()

@property (nonatomic, strong) JHImageView *bgImageView;

@property (nonatomic, strong) JHLabel *titleLabel;

@property (nonatomic, strong) JHTextView *textView;

@property (nonatomic, strong) JHButton *cancelBtn;

@property (nonatomic, strong) JHButton *importBtn;

@end

@implementation ZAAImportWalletViewController

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
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(@30);
        make.top.equalTo(@(260));
    }];
    
    [self.importBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.right.equalTo(@(-30));
        make.top.equalTo(@(260));
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
        _titleLabel.text = @"导入钱包";
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
        _textView.backgroundColor = kClearColor;
        _textView.textColor = kWhiteColor;
        [self.view addSubview:_textView];
    }
    return _textView;
}

- (JHButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[JHButton alloc] init];
        [_cancelBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kAppFont(15);
        [_cancelBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(touchCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (JHButton *)importBtn {
    if (!_importBtn) {
        _importBtn = [[JHButton alloc] init];
        [_importBtn setTitle:@"导入" forState:UIControlStateNormal];
        [_importBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        _importBtn.titleLabel.font = kAppFont(15);
        [_importBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_importBtn addTarget:self action:@selector(touchImportBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_importBtn];
    }
    return _importBtn;
}

- (void)touchCancelBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchImportBtn:(UIButton *)sender {
    WeakSelf;
    ZAACreateWalletViewController *vc = [[ZAACreateWalletViewController alloc] init];
    vc.fromType = ZAACreateFromType_Import;
    vc.onCreate = ^(BOOL success, NSString *pin) {
        [weakSelf handleCreate:success pin:pin];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleCreate:(BOOL)success pin:(NSString *)pin {
    if (success) {
        if (self.onApply) {
            self.onApply();
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
