//
//  ShopCartPayViewController.m
//  weidong
//
//  Created by zhccc on 2017/12/13.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ShopCartPayViewController.h"
#import "RedirectModule.h"
#import <MJExtension/MJExtension.h>
#import "SecurityUtil.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"

@interface ShopCartPayViewController () <UIWebViewDelegate>

@end

@implementation ShopCartPayViewController{
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
    [self initNaviBackButton];
    self.title = @"订单结算";
    
    [self clearLocalCookie];
    
    self.funcBaseUrl = [NSString stringWithFormat:@"/order/checkout?productType=%ld",_productType];
    self.previosUrl = [NSString stringWithFormat:@"%@/cart/list",SERVER_HTTP_BASE];
    schemeUrl = [Util getURLScheme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    
    if (![Util userIsLogin]) {
        [self openLoginVC];
        return;
    }
    
    NSString *userName = [Util getUserName];
    NSString *password = [Util getUserPassword];
    RedirectModule *model = [RedirectModule modelWithName:userName Password:password URL:_funcBaseUrl];
    NSData *sourceData = [NSJSONSerialization dataWithJSONObject:[model mj_keyValues] options:NSJSONWritingPrettyPrinted error:nil];
    redirectPart = [SecurityUtil encryptAESData:sourceData]; //不一致更新重定向片段
    
    //1.2 判断是否为h5首页
    //构造重定向地址、web界面地址
    h5Url  = [NSString stringWithFormat:@"%@%@",SERVER_HTTP_BASE, self.funcBaseUrl];
    webUrl = [NSString stringWithFormat:@"%@/appRedirect.jsp?%@",SERVER_HTTP_BASE, redirectPart];
    
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

- (void)clearLocalCookie {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除webView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)loadWithUrlStr:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
    [_webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [request.URL absoluteString];
    NSLog(urlString);
    
    __weak ShopCartPayViewController* wself = self;
    BOOL isIntercepted = [[AlipaySDK defaultService] payInterceptorWithUrl:[request.URL absoluteString] fromScheme:schemeUrl callback:^(NSDictionary *result) {
        // 处理支付结果
        NSLog(@"%@", result);
        // isProcessUrlPay 代表 支付宝已经处理该URL
        if ([result[@"isProcessUrlPay"] boolValue]) {
            // returnUrl 代表 第三方App需要跳转的成功页URL
            NSString* urlStr = result[@"returnUrl"];
            if (STRING_NULL(urlStr)) {
                //支付失败，直接跳转到订单界面
                urlStr = [NSString stringWithFormat:@"%@%@",SERVER_HTTP_BASE, @"/member/order/list"];
            }
            [wself loadWithUrlStr:urlStr];
        }
    }];
    
    if (isIntercepted) {
        return NO;
    }
    
    /* 拦截微信支付 */
    if ([urlString hasPrefix:@"weixin://"]) {
        if ([urlString containsString:@"&amp;"]) {
            [urlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        }
        NSURL *url = [NSURL URLWithString:urlString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                    
                }];
            }
            else {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
        return NO;
    }
    
    NSString *prevString = [urlString stringByRemovingPercentEncoding];
    urlString = [urlString stringByRemovingPercentEncoding];
    //拦截主页
    if ([urlString isEqualToString:SERVER_HOME_URL]) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    //拦截微动币列表界面
    if ([urlString isEqualToString:SERVER_DepositList_URL]) {
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    if ([prevString isEqualToString:_previosUrl]) {
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
