//
//  EgouCardViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/17.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "EgouCardViewController.h"
#import "VerifyCodeView.h"
#import "GetVerifyCodeRequest.h"
#import "CheckVerifyCodeRequest.h"
#import "EgouCardDepositRequest.h"

@interface EgouCardViewController () <UITextFieldDelegate, LVKeyboardDelegate, VerifiCodeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNoTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet VerifyCodeView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UIView *cardBgView;

@end

@implementation EgouCardViewController {
    NSString *serverVerify;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"易购卡充值";
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    
    _verifyCodeView.delegate = self;
    
    [self setupPositiveButtonStyle:_chargeBtn];
    _cardBgView.layer.cornerRadius = 8.0;
    [_cardBgView addShadowLayer];
    
    _passwordTF.inputAccessoryView = [LVKeyboardAccessoryBtn new];
    _passwordTF.inputView = self.keyboard;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getVerifyCode];
    
    _nameLabel.text = [Util getUserName];
    _amountLabel.text = [NSString stringWithFormat:@"￥%@", [_paramDic objectForKey:@"cardValue"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chargeBtnPressed:(id)sender {
    NSString *cardNo = _cardNoTF.text;
    NSString *password = _passwordTF.text;
    NSString *verifyCode = _verifyTF.text;
    
    if (STRING_NULL(cardNo)) {
        [SVProgressHUD showInfoWithStatus:@"请输入额购卡卡号"];
        return;
    }
    if (STRING_NULL(password)) {
        [SVProgressHUD showInfoWithStatus:@"请输入易购卡密码"];
        return;
    }
    if (STRING_NULL(verifyCode)) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
//    if (![serverVerify isEqualToString:verifyCode]) {
//        [SVProgressHUD showInfoWithStatus:@"验证码错误"];
//        return;
//    }
//
//    [self checkVerifyCode];
    [self cardDeposit];
}

- (void)getVerifyCode {
    [SVProgressHUD showWithStatus:@"获取验证码"];
    GetVerifyCodeRequest *request = [GetVerifyCodeRequest new];
    request.type = VerifyCodeType_Other;
    [request excuteRequst:^(Boolean isOK, NSString *verifyCode, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            serverVerify = verifyCode;
            [_verifyCodeView setupWithCode:verifyCode];
        }
        else {
//            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

//验证验证码
- (void)checkVerifyCode {
    [SVProgressHUD showWithStatus:@"正在充值"];
    CheckVerifyCodeRequest *request = [CheckVerifyCodeRequest new];
    request.type = VerifyCodeType_Other;
    request.verifyCode = _verifyTF.text;
    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [self cardDeposit];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [self getVerifyCode];
        }
    }];
}

- (void)cardDeposit {
    [SVProgressHUD showWithStatus:@"正在充值"];
    EgouCardDepositRequest *request = [EgouCardDepositRequest new];
    request.cardNo = _cardNoTF.text;
    NSString *encryptStr = [SecurityUtil encryptAESString:_passwordTF.text];
    request.cardPassword = encryptStr;
    request.transactionId = [_paramDic valueForKey:@"transactionId"];
    request.cardValue = [_paramDic valueForKey:@"cardValue"];
    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"充值成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            return;
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}


- (void)needChangeVerifyCode {
    serverVerify = @"";
    [self getVerifyCode];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.passwordTF.text = nil;
    self.passWord = nil;
    
    CGFloat x = 0;
    CGFloat y = self.view.height - 216;
    CGFloat w = self.view.width;
    CGFloat h = 216;
    self.keyboard = [[LVKeyboardView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.keyboard.delegate = self;
    
    self.passwordTF.inputView = _keyboard;
    
    return YES;
}

#pragma mark - LVKeyboardDelegate
- (void)keyboard:(LVKeyboardView *)keyboard didClickButton:(UIButton *)button {
    
    if (self.passWord.length > 5) return;
    [self.passWord appendString:button.currentTitle];
    
    self.passwordTF.text = self.passWord;
    NSLog(@"%@", self.passwordTF.text);
}

- (void)keyboard:(LVKeyboardView *)keyboard didClickDeleteBtn:(UIButton *)deleteBtn {
    NSLog(@"删除");
    NSUInteger loc = self.passWord.length;
    if (loc == 0)   return;
    NSRange range = NSMakeRange(loc - 1, 1);
    [self.passWord deleteCharactersInRange:range];
    self.passwordTF.text = self.passWord;
    NSLog(@"%@", self.passwordTF.text);
}

#pragma mark - 需要
- (NSMutableString *)passWord {
    if (!_passWord) {
        _passWord = [NSMutableString new];
    }
    return _passWord;
}

@end
