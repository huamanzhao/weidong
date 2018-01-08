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

@end

@implementation PersonalInfoViewController {
    NSInteger gender;
    SelfInfo *selfInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self initNaviBackButton];
    
    gender = 0;
    [self setupPositiveButtonStyle:_confirmBtn];
    [self setupNegativeButtonStyle:_backBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getSelfInfo];
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
    selfInfo.mobile   = _mobileTF.text;
    selfInfo.nickname = _nickTF.text;
    selfInfo.name     = _nameTF.text;
    selfInfo.idNumber = _idCardTF.text;
    selfInfo.gender   = gender;
    selfInfo.phone    = _phoneTF.text;
    
    [SVProgressHUD showWithStatus:@"正在提交"];
    UpdateSelfInfoRequest *request = [UpdateSelfInfoRequest new];
    request.info = selfInfo;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
            [selfInfo recordToLocal];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

- (void)checkRealIdentify {
    [SVProgressHUD showWithStatus:@"正在提交"];
    CheckRealIdentifyRequest *request = [CheckRealIdentifyRequest new];
    request.name = _nameTF.text;
    request.cardNo = _idCardTF.text;
    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [self getSelfInfo];
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
    NSString *name   = _nameTF.text;
    NSString *idCard = _idCardTF.text;
    
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
    
    if (!STRING_NULL(name) && !STRING_NULL(idCard) && !selfInfo.isVerify) {
        [self checkRealIdentify];
    }
    
    [self updateSelfInfo];
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

@end
