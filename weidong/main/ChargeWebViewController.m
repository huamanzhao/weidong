//
//  ChargeWebViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/26.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ChargeWebViewController.h"
#import "WebBaseViewController.h"

@interface ChargeWebViewController ()

@end

@implementation ChargeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微动币充值";
    
    self.funcBaseUrl = @"/member/deposit/recharge?deviceType=mobile";
    self.previosUrl = SERVER_MEMBERCETER_URL;
}



@end
