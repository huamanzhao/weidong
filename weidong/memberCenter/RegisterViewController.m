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
#import "VerifyCodeView.h"
#import "UserProtocolViewController.h"

@interface RegisterViewController () <VerifiCodeDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UIView *personalBgView;
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardNoTF;

@property (weak, nonatomic) IBOutlet VerifyCodeView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *personalHeightCS;
@property (weak, nonatomic) IBOutlet UIView *verifyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyHeightCS;

@end

@implementation RegisterViewController {
    NSInteger gender; //0-男 1-女
    NSString *serverVerify;
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
//    [_verifyBgView setRoundBorder];
    [_registerBtn setRoundCorner];
    [self setupPositiveButtonStyle:_registerBtn];
    
//    [_personalBgView setHidden:YES];
//    _personalHeightCS.constant = 0;
    
    [_verifyView setHidden:YES];
    _verifyHeightCS.constant = 0;
    _personalHeightCS.constant = 0;
    
    _verifyCodeView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self getVerifyCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)needChangeVerifyCode {
//    serverVerify = @"";
//    [self getVerifyCode];
//}

////请求验证码
//- (void)getVerifyCode {
//    GetVerifyCodeRequest *request = [GetVerifyCodeRequest new];
//    request.type = VerifyCodeType_Register;
//    [request excuteRequst:^(Boolean isOK, NSString *verifyCode, NSString * _Nullable errorMsg) {
//        if (isOK) {
//            serverVerify = verifyCode;
//            [_verifyCodeView setupWithCode:verifyCode];
//        }
//        else {
////            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat: @"请求验证码失败：%@", errorMsg]];
//        }
//    }];
//}

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
//    NSString *inputVerify = _verifyTF.text;
//    NSString *realName = _realNameTF.text;
//    NSString *idCardNo = _idCardNoTF.text;
    
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
//    if (STRING_NULL(inputVerify)) {
//        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
//        return;
//    }
//    if (![inputVerify isEqualToString:serverVerify]) {
//        [SVProgressHUD showInfoWithStatus:@"验证码错误"];
//        return;
//    }
    
    //1. 验证验证码
//    [SVProgressHUD showWithStatus:@"正在注册"];
//    CheckVerifyCodeRequest *request = [CheckVerifyCodeRequest new];
//    request.type = VerifyCodeType_Register;
//    request.verifyCode = inputVerify;
//    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
//        if (!isOK) {
//            [SVProgressHUD dismiss];
//            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"验证失败：%@", errorMsg]];
//        }
    
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
//                [self needChangeVerifyCode];
            }
            //注册成功后，返回登录界面
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
//    }];
}

- (IBAction)protocolBtnPressed:(id)sender {
    UserProtocolViewController *protocolVC = [UserProtocolViewController new];
    [self.navigationController pushViewController:protocolVC animated:YES];
}

- (IBAction)loginBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
