//
//  ChangePswdViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/3.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ChangePswdViewController.h"
#import "ChangePasswordRequest.h"

@interface ChangePswdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *currentPswdTF;
@property (weak, nonatomic) IBOutlet UITextField *freshPswdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPswdTF;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation ChangePswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self initNaviBackButton];
    [self initNaviTopEdge];
    
    [self initSubviewLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubviewLayout {
    [_currentPswdTF setRoundBorder];
    [_freshPswdTF setRoundBorder];
    [_confirmPswdTF setRoundBorder];
    
    _okBtn.backgroundColor = POSITIVE_COLOR;
    [_okBtn setRoundCorner];
    _backBtn.backgroundColor = NEGATIVE_COLOR;
    [_backBtn setRoundCorner];
}

- (IBAction)okBtnPressed:(id)sender {
    NSString *oldPsw = _currentPswdTF.text;
    NSString *newPsw = _freshPswdTF.text;
    NSString *confirm = _confirmPswdTF.text;
    
    if (STRING_NULL(oldPsw)) {
        [SVProgressHUD showErrorWithStatus:@"请输入当前密码"];
        return;
    }
    if (STRING_NULL(newPsw)) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码"];
        return;
    }
    if (STRING_NULL(confirm)) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入新密码"];
        return;
    }
    if (![newPsw isEqualToString:confirm]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在修改"];
    ChangePasswordRequest *request = [ChangePasswordRequest new];
    request.currentPassword = oldPsw;
    request.password = newPsw;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            //更新用户密码
            [Util updateUserPassword:newPsw];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"修改失败：%@", errorMsg]];
        }
    }];
}

- (IBAction)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
