//
//  PersonalInfoViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "UpdateSelfInfoRequest.h"
#import "GetSelfInfoRequest.h"
#import "CheckRealIdentifyRequest.h"
#import "SendSmsVerifycodeRequest.h"
#import "VerifySmsCodeRequest.h"

@interface PersonalInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *nickTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
//@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
//@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *genderBgView;
@property (weak, nonatomic) IBOutlet UILabel *verifyNoticeLabel;

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changBtnWidthCS;

@property (weak, nonatomic) IBOutlet UIView *changeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *changeViewHeightCS;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *secPhoneTF;


@end

@implementation PersonalInfoViewController {
    NSInteger gender;
    SelfInfo *selfInfo;
    
    BOOL inChange;
    NSInteger count;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    gender = 0;
    [self setupPositiveButtonStyle:_confirmBtn];
    [self setupNegativeButtonStyle:_backBtn];
    
    _changeBtn.layer.cornerRadius = 4.0;
    _verifyBtn.layer.cornerRadius = 4.0;
    _changeBtn.backgroundColor = NEGATIVE_COLOR;
    _verifyBtn.backgroundColor = POSITIVE_COLOR;
    
    inChange = NO;
    [self setupPhoneChangeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getSelfInfo];
}

- (void)setupPhoneChangeView {
    if (!inChange) {
        [_changeBtn setTitle:@"更换手机号码" forState:UIControlStateNormal];
        _changeView.hidden = YES;
        _changeViewHeightCS.constant = 0;
    }
    else {
        [_changeBtn setTitle:@"取消" forState:UIControlStateNormal];
        _changeView.hidden = NO;
        _changeViewHeightCS.constant = 147;
    }
}

- (void)updateData {
    if (!selfInfo || STRING_NULL(selfInfo.username)) {
        return;
    }
    
    _emailTF.text = selfInfo.email;
    _mobileTF.text = selfInfo.mobile;
    _nickTF.text = selfInfo.nickname;
    _nameTF.text = selfInfo.name;
    _idCardTF.text = selfInfo.idNumber;
    _phoneTF.text = selfInfo.phone;
    
    if (!STRING_NULL(selfInfo.mobile)) {
        [_mobileTF setBorderStyle:UITextBorderStyleNone];
        [_mobileTF setEnabled:NO];
    }
    
    if (selfInfo.isVerify) { //已实名认证
        [_verifyNoticeLabel setText:@"*您已实名认证"];
        _nameTF.userInteractionEnabled = NO;
        _idCardTF.userInteractionEnabled = NO;
        _nameTF.borderStyle = UITextBorderStyleNone;
        _idCardTF.borderStyle = UITextBorderStyleNone;
    }
}

- (void)getSelfInfo {
    [SVProgressHUD showWithStatus:@"正在获取个人信息"];
    GetSelfInfoRequest *request = [GetSelfInfoRequest new];
    [request excuteRequest:^(BOOL isOK, SelfInfo * _Nullable info, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        selfInfo = info;
        [selfInfo recordToLocal];
        [self updateData];
    }];
}

- (void)updateSelfInfo {
    if (!selfInfo) {
        selfInfo = [SelfInfo new];
    }
    selfInfo.username = [Util getUserName];
    selfInfo.password = [Util getUserPassword];
    selfInfo.email    = _emailTF.text;
    selfInfo.mobile   = (inChange && !STRING_NULL(_verifyTF.text)) ? _secPhoneTF.text : _mobileTF.text;
    selfInfo.nickname = _nickTF.text;
    selfInfo.memberAttribute_1  = _nameTF.text;
    selfInfo.memberAttribute_51 = _idCardTF.text;
    selfInfo.gender   = gender;
    selfInfo.phone    = _phoneTF.text;
    
    [SVProgressHUD showWithStatus:@"正在提交"];
    UpdateSelfInfoRequest *request = [UpdateSelfInfoRequest new];
    request.info = selfInfo;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            GetSelfInfoRequest *request = [GetSelfInfoRequest new];
            [request excuteRequest:^(BOOL isOK, SelfInfo * _Nullable info, NSString * _Nullable errorMsg) {
                [SVProgressHUD dismiss];
                if (!isOK) {
                    [SVProgressHUD showErrorWithStatus:errorMsg];
                    return;
                }
                
                selfInfo = info;
                [selfInfo recordToLocal];
                
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

//- (IBAction)maleBtnPressed:(id)sender {
//    gender = 0;
//    [_maleBtn setImage:UIImageWithName(@"btn_checked") forState:UIControlStateNormal];
//    [_femaleBtn setImage:UIImageWithName(@"btn_uncheck") forState:UIControlStateNormal];
//}
//
//- (IBAction)femaleBtnPressed:(id)sender {
//    gender = 1;
//    [_femaleBtn setImage:UIImageWithName(@"btn_checked") forState:UIControlStateNormal];
//    [_maleBtn setImage:UIImageWithName(@"btn_uncheck") forState:UIControlStateNormal];
//}

- (IBAction)confirmBtnPressed:(id)sender {
    NSString *email  = _emailTF.text;
    NSString *mobile = _mobileTF.text;
    //    NSString *name   = _nameTF.text;
    //    NSString *idCard = _idCardTF.text;
    
    if (STRING_NULL(email)) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的邮箱"];
        return;
    }
    if (STRING_NULL(mobile)) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号码"];
        return;
    }
    if (![mobile checkPhoneNumInput]) {
        [SVProgressHUD showErrorWithStatus:@"您输入的手机号码格式错误"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在验证"];
    
    //判断是否要验证短信验证码
    if (!inChange) {
        [self updateSelfInfo];
        
        return;
    }
    
    
    if (STRING_NULL(_secPhoneTF.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入新的手机号码"];
        return;
    }
    if (![_secPhoneTF.text checkPhoneNumInput]) {
        [SVProgressHUD showErrorWithStatus:@"新的手机号码格式错误"];
        return;
    }
    
    [self verifySmsCode];
}


- (void)verifySmsCode {
    VerifySmsCodeRequest *request = [VerifySmsCodeRequest new];
    request.mobile = _mobileTF.text;
    request.verifyCode = _verifyTF.text;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"验证失败：%@", errorMsg]];
            return;
        }
        
        [self updateSelfInfo];
    }];
}

- (IBAction)backBtnPressed:(id)sender {
    NSString *title = @"确定要退出本次编辑吗？";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (IBAction)changeBtnPressed:(id)sender {
    inChange = !inChange;
    
    [self setupPhoneChangeView];
}

- (IBAction)verifyBtnPressed:(id)sender {
    _verifyBtn.userInteractionEnabled = NO;
    NSString *mobile = _mobileTF.text;
    if (STRING_NULL(mobile)) {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
        
        _verifyBtn.userInteractionEnabled = YES;
        return;
    }
    if (![mobile checkPhoneNumInput]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号码"];
        
        _verifyBtn.userInteractionEnabled = YES;
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
            _verifyBtn.userInteractionEnabled = YES;
        }
    }];
}

- (void)setSendBtnEnabled:(BOOL)enable {
    [_verifyBtn setUserInteractionEnabled:enable];
    
    if (enable) {
        _verifyBtn.backgroundColor = POSITIVE_COLOR;
    }
    else {
        _verifyBtn.backgroundColor = [UIColor grayColor];
    }
}

- (void)startSendButtonCountdown {
    [self setSendBtnEnabled:NO];
    
    count = 60;
    [_verifyBtn setTitle:[NSString stringWithFormat:@"%lds", (long)count] forState:UIControlStateNormal];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown) userInfo:nil repeats:YES];
}

- (void)timerCountdown {
    count--;
    
    [_verifyBtn setTitle:[NSString stringWithFormat:@"%lds", (long)count] forState:UIControlStateNormal];
    
    if (0 == count) {
        [timer invalidate];
        
        [self setSendBtnEnabled:YES];
        [_verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
}

@end
