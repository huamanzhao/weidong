//
//  MyOrdersViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "LoginViewController.h"
#import <WebKit/WebKit.h>
#import <AlipaySDK/AlipaySDK.h>

@interface MyOrdersViewController () <WKNavigationDelegate>

@end

@implementation MyOrdersViewController{
    WKWebView *webView;
    NSString *urlStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    self.funcBaseUrl = @"/member/order/list";
    self.previosUrl = SERVER_MEMBERCETER_URL;
}

@end
