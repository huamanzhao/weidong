//
//  ForgetViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/3.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ForgetViewController.h"
#import "ResetPasswordRequest.h"
#import "SendSmsVerifycodeRequest.h"
#import "ResetPasswordRequest.h"

@interface ForgetViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@end

@implementation ForgetViewController {
    NSInteger count;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    [self initNaviBackButton];
    
    [self initSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubView {
    _bgView.layer.cornerRadius = 6.0;
    [_bgView addShadowLayer];
    
    _sendBtn.layer.cornerRadius = 4.0;
    _sendBtn.backgroundColor = POSITIVE_COLOR;
    
    _okBtn.layer.cornerRadius = 4.0;
    _okBtn.backgroundColor = POSITIVE_COLOR;
}

- (void)setSendBtnEnabled:(BOOL)enable {
    [_sendBtn setUserInteractionEnabled:enable];
    
    if (enable) {
        _sendBtn.backgroundColor = POSITIVE_COLOR;
    }
    else {
        _sendBtn.backgroundColor = [UIColor grayColor];
    }
}

- (void)startSendButtonCountdown {
    [self setSendBtnEnabled:NO];
    
    count = 60;
    [_sendBtn setTitle:[NSString stringWithFormat:@"%lds", (long)count] forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

- (void)timerCountdown {
    count--;
    
    [_sendBtn setTitle:[NSString stringWithFormat:@"%lds", (long)count] forState:UIControlStateNormal];
    
    if (0 == count) {
        [timer invalidate];
        
        [self setSendBtnEnabled:YES];
        [_sendBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

- (IBAction)sendBtnPressed:(id)sender {
    _sendBtn.userInteractionEnabled = NO;
    NSString *mobile = _mobileTF.text;
    if (STRING_NULL(mobile)) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    if (![mobile checkPhoneNumInput]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在请求"];
    SendSmsVerifycodeRequest *request = [SendSmsVerifycodeRequest new];
    request.mobile = mobile;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showInfoWithStatus:@"验证码短信已发送，请注意查收"];
            [self startSendButtonCountdown];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            _sendBtn.userInteractionEnabled = YES;
        }
    }];
}

- (IBAction)okbtnPressed:(id)sender {
    NSString *mobile = _mobileTF.text;
    NSString *verify = _verifyTF.text;
    NSString *password = _passwordTF.text;
    NSString *confirm = _confirmTF.text;
    
    if (STRING_NULL(mobile)) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    if (![mobile checkPhoneNumInput]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if (STRING_NULL(verify)) {
        [SVProgressHUD showErrorWithStatus:@"请输入短信验证码"];
        return;
    }
    if (STRING_NULL(password)) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的新密码"];
        return;
    }
    if (STRING_NULL(confirm)) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新的密码"];
        return;
    }
    if (![password isEqualToString:confirm]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的新密码不相同"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在发送请求"];
    ResetPasswordRequest *request = [ResetPasswordRequest new];
    request.mobile = mobile;
    request.verifyCode = verify;
    request.password = password;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"您的密码已经重置成功，请返回重新登录"];
            
            //更新本地密码
            [Util updateUserPassword:password];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

@end
