//
//  RealNameVerifyViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/12.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RealNameVerifyViewController.h"
#import "CheckRealIdentifyRequest.h"
#import "GetSelfInfoRequest.h"

@interface RealNameVerifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;


@end

@implementation RealNameVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"实名认证";
    [self initNaviBackButton];
    
    [self setupPositiveButtonStyle:_verifyBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)verifyBtnPressed:(id)sender {
    NSString *name = _nameTF.text;
    NSString *cardNo = _idCardTF.text;
    
    if (STRING_NULL(name)) {
        [SVProgressHUD showInfoWithStatus:@"请输入姓名"];
        return;
    }
    
    if (STRING_NULL(cardNo)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的身份证号"];
        return;
    }
    
    if (![cardNo checkIDNumber]) {
        [SVProgressHUD showInfoWithStatus:@"您输入的身份证号码有误"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在提交"];
    CheckRealIdentifyRequest *request = [CheckRealIdentifyRequest new];
    request.name = name;
    request.cardNo = cardNo;
    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [self updateSelfInfo];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

//更新个人信息
- (void)updateSelfInfo {
    GetSelfInfoRequest *request = [GetSelfInfoRequest new];
    [request excuteRequest:^(BOOL isOK, SelfInfo * _Nullable info, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [info recordToLocal];
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:errorMsg];
        }
    }];
}


@end
