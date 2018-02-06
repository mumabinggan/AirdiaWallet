//
//  ZAAPasswordInputView.m
//  AirdiaWallet
//
//  Created by muma on 2018/2/5.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ZAAPasswordInputView.h"

static int kDotCount = 6;
static float kFieldheight = 45;

@interface ZAAPasswordInputView () <UITextFieldDelegate>

@property (nonatomic, strong) JHTextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray;

@end

@implementation ZAAPasswordInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    [self initPwdTextField];
}

- (void)initPwdTextField
{
    CGSize kDotSize = CGSizeMake(30, 30);
    //每个密码输入框的宽度
    CGFloat width = (self.frame.size.width) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, kFieldheight)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotSize.width) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (kFieldheight - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        if (self.onApply) {
            self.onApply(textField.text);
        }
        NSLog(@"输入完毕");
    }
}

/**
 * /禁止可被粘贴复制
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[JHTextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kFieldheight)];
        _textField.backgroundColor = kClearColor;
        //输入的文字颜色为白色
        _textField.textColor = kClearColor;
        //输入框光标的颜色为白色
        _textField.tintColor = kClearColor;
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
        [_textField becomeFirstResponder];
    }
    return _textField;
}

@end
