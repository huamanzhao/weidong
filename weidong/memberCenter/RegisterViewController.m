//
//  RegisterViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/1.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetVerifyCodeRequest.h"
#import "CheckVerifyCodeRequest.h"
#import "RegisterRequest.h"
#import "UserProtocolViewController.h"
#import "SendSmsVerifycodeRequest.h"
#import "VerifySmsCodeRequest.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UIView *personalBgView;
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardNoTF;

//@property (weak, nonatomic) IBOutlet VerifyCodeView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personalHeightCS;
@property (weak, nonatomic) IBOutlet UIView *verifyView;

@end

@implementation RegisterViewController {
    NSInteger gender; //0-男 1-女
    NSString *serverVerify;
    NSInteger count;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    gender = 0;     //默认为男性
    serverVerify = @"";
    
    [_userNameTF setRoundBorder];
    [_passwordTF setRoundBorder];
    [_confirmTF setRoundBorder];
    [_emailTF setRoundBorder];
    [_phoneTF setRoundBorder];
    [_realNameTF setRoundBorder];
    [_idCardNoTF setRoundBorder];
    [_verifyTF setRoundBorder];
    [_registerBtn setRoundCorner];
    [self setupPositiveButtonStyle:_registerBtn];
    
    _personalHeightCS.constant = 0;
    
    _sendBtn.layer.cornerRadius = 4.0;
    _sendBtn.backgroundColor = POSITIVE_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maleBtnPressed:(id)sender {
    gender = 0;
    [_maleBtn setImage:UIImageWithName(@"btn_checked") forState:UIControlStateNormal];
    [_femaleBtn setImage:UIImageWithName(@"btn_uncheck") forState:UIControlStateNormal];
}

- (IBAction)femaleBtnPressed:(id)sender {
    gender = 1;
    [_femaleBtn setImage:UIImageWithName(@"btn_checked") forState:UIControlStateNormal];
    [_maleBtn setImage:UIImageWithName(@"btn_uncheck") forState:UIControlStateNormal];
}

- (IBAction)registerBtnPressed:(id)sender {
    NSString *userName = _userNameTF.text;
    NSString *password = _passwordTF.text;
    NSString *confirmPsw = _confirmTF.text;
    NSString *email = _emailTF.text;
    NSString *phone = _phoneTF.text;
    NSString *verifyCode = _verifyTF.text;
    
    if (STRING_NULL(userName)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的用户名"];
        return;
    }
    if ([userName length] < 4) {
        [SVProgressHUD showInfoWithStatus:@"用户名长度不能少于4位"];
        return;
    }
    if (STRING_NULL(password)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的密码"];
        return;
    }
    if ([userName length] < 4) {
        [SVProgressHUD showInfoWithStatus:@"密码长度不能少于4位"];
        return;
    }
    if (![password isEqualToString:confirmPsw]) {
        [SVProgressHUD showInfoWithStatus:@"您两次输入的密码不一样"];
        return;
    }
    if (STRING_NULL(email)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的邮箱"];
        return;
    }
    if (![email checkEmailAccount]) {
        [SVProgressHUD showInfoWithStatus:@"您输入的邮箱格式错误"];
        return;
    }
    if (STRING_NULL(phone)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的电话号码"];
        return;
    }
    if (![phone checkPhoneNumInput]) {
        [SVProgressHUD showInfoWithStatus:@"您输入的手机号码格式错误"];
        return;
    }
    if (STRING_NULL(verifyCode)) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
    
    //1. 验证验证码
    [SVProgressHUD showWithStatus:@"正在注册"];
    VerifySmsCodeRequest *request = [VerifySmsCodeRequest new];
    request.mobile = phone;
    request.verifyCode = verifyCode;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"验证失败：%@", errorMsg]];
            return;
        }
    
        //2. 验证通过后开始注册
        [SVProgressHUD showWithStatus:@"正在注册"];
        RegisterRequest *request = [RegisterRequest new];
        request.username = userName;
        request.password = password;
        request.email = email;
        request.gender = gender;
        request.phone = phone;
        request.mobile = phone;
        [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
            [SVProgressHUD dismiss];
            if (!isOK) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"注册失败：%@", errorMsg]];
                return;
            }
            //注册成功后，返回登录界面
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (IBAction)protocolBtnPressed:(id)sender {
    UserProtocolViewController *protocolVC = [UserProtocolViewController new];
    [self.navigationController pushViewController:protocolVC animated:YES];
}

- (IBAction)loginBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendBtnPressed:(id)sender {
    _sendBtn.userInteractionEnabled = NO;
    NSString *mobile = _phoneTF.text;
    if (STRING_NULL(mobile)) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
        
        _sendBtn.userInteractionEnabled = YES;
        return;
    }
    if (![mobile checkPhoneNumInput]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        
        _sendBtn.userInteractionEnabled = YES;
        return;
    }
    
    [self startSendButtonCountdown];
    SendSmsVerifycodeRequest *request = [SendSmsVerifycodeRequest new];
    request.mobile = mobile;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [SVProgressHUD showInfoWithStatus:@"验证码短信已发送，请注意查收"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            _sendBtn.userInteractionEnabled = YES;
        }
    }];
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

@end
