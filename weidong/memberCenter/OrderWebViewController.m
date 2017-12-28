//
//  OrderWebViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "OrderWebViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"
#import "RedirectModule.h"
#import "SecurityUtil.h"
#import <MJExtension/MJExtension.h>

@interface OrderWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic, copy)NSString *funcBaseUrl; //功能部分
@property(nonatomic, copy)NSString *previosUrl;

@end

@implementation OrderWebViewController {
    NSString *redirectPart; //重定向链接部分
    NSString *h5Url;        //购物车地址：基地址+功能部分
    NSString *webUrl;       //购物车地址: 基地址+重定向+功能部分
    NSString *schemeUrl;    //app schemeUrl;
    
    //上一次的用户名；
    NSString *lastUserName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStatusBarBGColor];
    [self setTintColor:ZHAO_BLUE];
    self.title = @"我的订单";
    
    if (self.orderType == OrderListType_Init) {
        self.funcBaseUrl = @"/member/order/list";
    }
    else if (self.orderType == OrderListType_waitPay) {
        self.funcBaseUrl = @"/member/order/list?status=pendingPayment";
    }
    else if (self.orderType == OrderListType_waitSend) {
        self.funcBaseUrl = @"/member/order/list?status=pendingShipment";
    }
    else if (self.orderType == OrderListType_waitReceive) {
        self.funcBaseUrl = @"/member/order/list?status=pendingShipment";
    }
    
    self.previosUrl = SERVER_MEMBERCETER_URL;
    schemeUrl = [Util getURLScheme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (![Util userIsLogin]) {
        [self openLoginVC];
        return;
    }
    
    NSString *userName = [Util getUserName];
    NSString *password = [Util getUserPassword];
    RedirectModule *model = [RedirectModule modelWithName:userName Password:password URL:self.funcBaseUrl];
    NSData *sourceData = [NSJSONSerialization dataWithJSONObject:[model mj_keyValues] options:NSJSONWritingPrettyPrinted error:nil];
    redirectPart = [SecurityUtil encryptAESData:sourceData]; //不一致更新重定向片段
    
    //1.2 判断是否为h5首页
    //构造重定向地址、web界面地址
    h5Url  = [NSString stringWithFormat:@"%@%@", SERVER_HTTP_BASE, self.funcBaseUrl];
    webUrl = [NSString stringWithFormat:@"%@/appRedirect.jsp?%@", SERVER_HTTP_BASE, redirectPart];
    
    //1. 如果是购物车首页，刷新此界面
    if (!_webView.canGoBack) {
        [self loadWithUrlStr:webUrl];
        lastUserName = userName;
        return;
    }
    
    //2. 不是购物车首页了
    //2.1 更换过登录用户
    if (![lastUserName isEqualToString:userName]) {
        [self loadWithUrlStr:webUrl];
        lastUserName = userName;
        return;
    }
    
    //2.2没有更换登录用户
    [_webView reload];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadWithUrlStr:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [request.URL absoluteString];
    
    __weak OrderWebViewController* wself = self;
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:schemeUrl callback:^(NSDictionary *result) {
        // 处理支付结果
        NSLog(@"%@", result);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([result[@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = result[@"returnUrl"];
            [wself loadWithUrlStr:urlStr];
        }
    }];
    if (isIntercepted) {
        return NO;
    }
    
    NSString *prevString = [urlString stringByRemovingPercentEncoding];
    if ([prevString isEqualToString:_previosUrl]) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)openLoginVC {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:NO];
}

@end
