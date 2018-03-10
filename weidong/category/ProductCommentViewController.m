//
//  ProductCommentViewController.m
//  weidong
//
//  Created by zhccc on 2018/3/10.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "ProductCommentViewController.h"
#import "VerifyCodeView.h"
#import "GetProductDetailRequest.h"
#import "GetVerifyCodeRequest.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AddCommentRequest.h"

@interface ProductCommentViewController () <VerifiCodeDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIView *verifyBgView;
@property (weak, nonatomic) IBOutlet VerifyCodeView *verifyCodeView;
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

@end

@implementation ProductCommentViewController {
    ProductDetail *product;
    NSString *serverVerify;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品咨询";
    [self initNaviBackButton];
    
    _verifyCodeView.delegate = self;
    
    _nameLabel.textColor = ZHAO_BLUE;
    [_contentTV setRoundBorderWithRadius:8.0];
    [_verifyBgView setRoundBorderWithRadius:8.0];
    [self setupPositiveButtonStyle:_submitBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getVerifyCode];
    [self getProductDetailInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubView {
    _nameLabel.text = product.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.price];
}

- (void)getProductDetailInfo {
    [SVProgressHUD showWithStatus:@"正在加载商品信息"];
    GetProductDetailRequest *request = [GetProductDetailRequest new];
    request.productId = self.productId;
    [request excuteRequest:^(BOOL isOK, GetProductDetailResponse * _Nullable response, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (!isOK) {
            [SVProgressHUD showErrorWithStatus:errorMsg];
            return;
        }
        
        product = response.detail;
        [_productImage sd_setImageWithURL:[NSURL URLWithString:product.image]];
        [self setupSubView];
    }];
}

- (IBAction)submitBtnPressed:(id)sender {
    if ([_scoreLabel.text isEqualToString:@"0"]) {
        [SVProgressHUD showInfoWithStatus:@"你还未打分"];
        return;
    }
    
    if (STRING_NULL(_contentTV.text)) {
        [SVProgressHUD showInfoWithStatus:@"请填写评价内容"];
        return;
    }
    
    if (STRING_NULL(_verifyTF.text)) {
        [SVProgressHUD showInfoWithStatus:@"请填写验证码"];
        return;
    }
    
    [self submitComment];
}

- (void)submitComment {
    [SVProgressHUD showWithStatus:@"正在上传"];
    AddCommentRequest *request = [AddCommentRequest new];
    request.productId = self.productId;
    request.score = self.scoreLabel.text;
    request.content = self.contentTV.text;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"评价发表成功"];
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
    }];
}

- (void)needChangeVerifyCode {
    serverVerify = @"";
    [self getVerifyCode];
}

- (void)popBackVIewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scoreBtn1Pressed:(id)sender {
    [self cleanScore];
    
    [self setStarSelected:_button1];
    
    _scoreLabel.text = @"1";
}

- (IBAction)scoreBtn2Pressed:(id)sender {
    [self cleanScore];
    
    [self setStarSelected:_button1];
    [self setStarSelected:_button2];
    
    _scoreLabel.text = @"2";
}

- (IBAction)scoreBtn3Pressed:(id)sender {
    [self cleanScore];
    
    [self setStarSelected:_button1];
    [self setStarSelected:_button2];
    [self setStarSelected:_button3];
    
    _scoreLabel.text = @"3";
}

- (IBAction)scoreBtn4Pressed:(id)sender {
    [self cleanScore];
    
    [self setStarSelected:_button1];
    [self setStarSelected:_button2];
    [self setStarSelected:_button3];
    [self setStarSelected:_button4];
    
    _scoreLabel.text = @"4";
}

- (IBAction)scoreBtn5Pressed:(id)sender {
    [self cleanScore];
    
    [self setStarSelected:_button1];
    [self setStarSelected:_button2];
    [self setStarSelected:_button3];
    [self setStarSelected:_button4];
    [self setStarSelected:_button5];
    
    _scoreLabel.text = @"5";
}

- (void)setStarUnselect:(UIButton *)button {
    [button setImage:UIImageWithName(@"star_unselect") forState:UIControlStateNormal];
}

- (void)setStarSelected:(UIButton *)button {
    [button setImage:UIImageWithName(@"star_selected") forState:UIControlStateNormal];
}

- (void)cleanScore {
    [self setStarUnselect:_button1];
    [self setStarUnselect:_button2];
    [self setStarUnselect:_button3];
    [self setStarUnselect:_button4];
    [self setStarUnselect:_button5];
}

@end
