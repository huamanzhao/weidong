//
//  ProductConsulateViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductConsulateViewController.h"
#import "VerifyCodeView.h"
#import "GetVerifyCodeRequest.h"
#import "CheckVerifyCodeRequest.h"
#import "AddConsulationRequest.h"

@interface ProductConsulateViewController () <VerifiCodeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIView *verifyBgView;
@property (weak, nonatomic) IBOutlet VerifyCodeView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation ProductConsulateViewController {
    NSString *serverVerify;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品咨询";
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    
    _verifyCodeView.delegate = self;
    
    _nameLabel.textColor = ZHAO_BLUE;
    [_contentTV setRoundBorderWithRadius:8.0];
    [_verifyBgView setRoundBorderWithRadius:8.0];
    [self setupPositiveButtonStyle:_submitBtn];
    
    [self setupSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getVerifyCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubView {
    _nameLabel.text = _product.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _product.price];
}

- (IBAction)submitBtnPressed:(id)sender {
    if (STRING_NULL(_contentTV.text)) {
        [SVProgressHUD showInfoWithStatus:@"请填写咨询内容"];
        return;
    }
    
    if (STRING_NULL(_verifyTF.text)) {
        [SVProgressHUD showInfoWithStatus:@"请填写验证码"];
        return;
    }
    
//    if (![_verifyTF.text isEqualToString:serverVerify]) {
//        [SVProgressHUD showInfoWithStatus:@"您输入的验证码错误"];
//        return;
//    }
//
//    [self checkVerifyCode];
    [self submitConsulation];
}

- (void)submitConsulation {
    [SVProgressHUD showWithStatus:@"正在上传"];
    AddConsulationRequest *request = [AddConsulationRequest new];
    request.productId = _product.id;
    request.content = _contentTV.text;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"咨询发表成功"];
            [self popBackVIewController];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
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
    [SVProgressHUD showWithStatus:@"正在验证"];
    CheckVerifyCodeRequest *request = [CheckVerifyCodeRequest new];
    request.type = VerifyCodeType_Other;
    request.verifyCode = _verifyTF.text;
    [request excuteRequst:^(Boolean isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [self submitConsulation];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            [self getVerifyCode];
        }
    }];
}


- (void)needChangeVerifyCode {
    serverVerify = @"";
    [self getVerifyCode];
}

- (void)popBackVIewController {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
