//
//  ChargeCenterViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/16.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ChargeCenterViewController.h"
#import "GetMemberBalanceRequest.h"
#import "EgouCardViewController.h"
#import "LoginViewController.h"

@interface ChargeCenterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIButton *alipayBtn;
@property (weak, nonatomic) IBOutlet UIButton *cardBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation ChargeCenterViewController {
    NSInteger paymentType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微动币充值";
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    
    [self setupPositiveButtonStyle:_confirmBtn];
    [self setupNegativeButtonStyle:_cancelBtn];
    
    paymentType = 0;
    [self setupPaymentTypeLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![Util userIsLogin]) {
        [self openLoginController];
        return;
    }
    
    [self getBalance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBalance {
    GetMemberBalanceRequest *request = [GetMemberBalanceRequest new];
    [request excuteRequest:^(BOOL isOK, GetMemberBalanceResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            _balanceLabel.text = [NSString stringWithFormat:@"￥%.2f", response.memberBalance];
        }
        else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取当前余额失败，原因：%@", errorMsg]];
        }
    }];
}

- (IBAction)alipayBtnPressed:(id)sender {
    paymentType = 0;
    [self setupPaymentTypeLayout];
}

- (IBAction)cardBtnPressed:(id)sender {
    paymentType = 1;
    [self setupPaymentTypeLayout];
}

- (IBAction)confirmBtnPressed:(id)sender {
    if (STRING_NULL(_amountTF.text)) {
        [SVProgressHUD showInfoWithStatus:@"请输入充值金额"];
        return;
    }
    
    if ([_amountTF.text floatValue] == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的充值金额"];
        return;
    }
    
    if (paymentType == 0) {
        [self openAlipayWebView];
    }
    else {
        [self openCartPayView];
    }
}

- (IBAction)cancelBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupPaymentTypeLayout {
    UIImage *selectedImage = UIImageWithName(@"btn_checked");
    UIImage *unselectImage = UIImageWithName(@"btn_uncheck");
    
    if (paymentType == 0) { //支付宝支付
        [_alipayBtn setImage:selectedImage forState:UIControlStateNormal];
        [_cardBtn   setImage:unselectImage forState:UIControlStateNormal];
    }
    else {
        [_alipayBtn setImage:unselectImage forState:UIControlStateNormal];
        [_cardBtn   setImage:selectedImage forState:UIControlStateNormal];
    }
}

- (void)openLoginController {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)openAlipayWebView {
    
}

- (void)openCartPayView {
    EgouCardViewController *cardVC = [EgouCardViewController new];
//    cardVC.amount = [_amountTF.text floatValue];
    [self.navigationController pushViewController:cardVC animated:NO];
}

@end
