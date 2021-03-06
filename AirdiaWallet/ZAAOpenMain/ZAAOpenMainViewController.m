//
//  ZAAOpenMainViewController.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/2.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAAOpenMainViewController.h"
#import "ZAALoginViewController.h"
#import "ZAAImportWalletViewController.h"
#import "ZAACreateWalletViewController.h"
#import "ZAALoginViewController.h"
#import "ZAALoginTypeSettingViewController.h"
#import "ZAAPrivateKeySaveViewController.h"

@interface ZAAOpenMainViewController ()

@property (nonatomic, strong) JHImageView *bgImageView;
@property (nonatomic, strong) JHButton *loginBtn;
@property (nonatomic, strong) JHButton *createBtn;
@property (nonatomic, strong) JHButton *importWalletBtn;

@end

@implementation ZAAOpenMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    self.navigationController.navigationBar.hidden = YES;
}

- (JHImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[JHImageView alloc] init];
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        _bgImageView.image = [UIImage imageNamed:@"open_main_bg"];
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}

- (JHButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [self createBtn:@"登录"];
        [_loginBtn addTarget:self action:@selector(touchLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
    }
    return _loginBtn;
}

- (JHButton *)createBtn {
    if (!_createBtn) {
        _createBtn = [self createBtn:@"创建"];
        [_createBtn addTarget:self action:@selector(touchCreateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_createBtn];
    }
    return _createBtn;
}

- (JHButton *)importWalletBtn {
    if (!_importWalletBtn) {
        _importWalletBtn = [self createBtn:@"Import Wallet"];
        [_importWalletBtn addTarget:self action:@selector(touchImportBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_importWalletBtn];
    }
    return _importWalletBtn;
}

- (void)initSubViews {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.importWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(200, 45)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kAppAdaptWidth(70));
    }];
    
    [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(200, 45)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.importWalletBtn).offset(-kAppAdaptWidth(70));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(CGSizeMake(200, 45)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.createBtn).offset(-kAppAdaptWidth(70));
    }];
}

- (JHButton *)createBtn:(NSString *)title {
    JHButton *btn = [[JHButton alloc] init];
    [btn setBackgroundColor:kRGBA(255, 255, 255, 0.5)];
    btn.layer.cornerRadius = 3;
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

- (void)touchLoginBtn:(UIButton *)sender {
    WeakSelf;
    ZAALoginViewController *vc = [[ZAALoginViewController alloc] init];
    vc.onLogin = ^(BOOL success) {
        [weakSelf handleLogin:success];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleLogin:(BOOL)success {
    if (success) {
        if (self.onApply) {
            self.onApply();
        }
    }
}

- (void)touchImportBtn:(UIButton *)sender {
    WeakSelf;
    ZAAImportWalletViewController *vc = [[ZAAImportWalletViewController alloc] init];
    vc.onApply = ^{
        [weakSelf handleImport];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleImport {
    if (self.onApply) {
        self.onApply();
    }
}

- (void)touchCreateBtn:(UIButton *)sender {
    WeakSelf;
    ZAACreateWalletViewController *vc = [[ZAACreateWalletViewController alloc] init];
    vc.fromType = ZAACreateFromType_Create;
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
