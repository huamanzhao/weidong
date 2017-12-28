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
    [self initNaviBackButton];
    
    webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    [self loadUrl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    webView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUrl {
    NSString *userName = [Util getUserName];
    NSString *password = [Util getUserPassword];
    if (!STRING_NULL(userName)  && !STRING_NULL(password)) {
        urlStr = [SERVER_TEST_HTTP_BASE stringByAppendingString:[NSString stringWithFormat:@"/appRedirect.jsp?username=%@&password=%@&url=/member/order/list", userName, password]];
        NSURL *webUrl = [NSURL URLWithString:urlStr];
        [webView loadRequest:[NSURLRequest requestWithURL:webUrl]];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    NSString *urlScheme = [Util getURLScheme];
    
    //拦截跳转支付宝支付URL
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:urlString fromScheme:urlScheme callback:^(NSDictionary *result) {
        // 处理支付结果
        NSLog(@"%@", result);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([result[@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = result[@"returnUrl"];
            //            [wself loadWithUrlStr:urlStr];
        }
    }];
    
    if (isIntercepted) {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    //拦截跳转个人中心界面
    urlString = [urlString stringByRemovingPercentEncoding];
    NSLog(@"urlString=%@",urlString);
    if ([urlString isEqualToString:SERVER_MEMBERCETER_URL]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

@end
