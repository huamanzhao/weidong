//
//  RefoundListWebViewController.m
//  weidong
//
//  Created by zhccc on 2018/1/28.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RefoundListWebViewController.h"
#import "LoginViewController.h"
#import <WebKit/WebKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import <MJExtension/MJExtension.h>
#import "RedirectModule.h"
#import "SecurityUtil.h"

@interface RefoundListWebViewController () <WKNavigationDelegate>
@property(nonatomic, copy)NSString *funcBaseUrl; //功能部分
@property(nonatomic, copy)NSString *previosUrl;
@end

@implementation RefoundListWebViewController  {
    WKWebView *webView;
    NSString *redirectPart;  //重定向链接部分
    NSString *h5Url;    //H5网页访问的地址：基地址+功能部分
    NSString *webUrl;       //webview加载Url
    
    BOOL needReload;    //是否需要重新加载
    
    //上一次的用户名；
    NSString *lastUserName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBackButton];
    [self initStatusBarBGColor];
    [self setTintColor:ZHAO_BLUE];
    [self initNaviTopEdge];
    self.title = @"我的退货";
    
    //初始化webview
    webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    
    needReload = YES;
    
    self.funcBaseUrl = @"/member/order/applyReturnList";
    self.previosUrl = SERVER_MEMBERCETER_URL;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![Util userIsLogin]) {
        [self openLoginVC];
        return;
    }
    
    NSString *userName = [Util getUserName];
    NSString *password = [Util getUserPassword];
    
    /// 1 判断界面是否需要重新加载
    //1.1 判断上一次用户名跟当前登录的用户名是否一致
    if (lastUserName) {
        if (![lastUserName isEqualToString:userName]) { //不一致需要刷新
            needReload = YES;
        }
    }
    else {
        needReload = YES;
    }
    
    RedirectModule *model = [RedirectModule modelWithName:userName Password:password URL:_funcBaseUrl];
    NSData *sourceData = [NSJSONSerialization dataWithJSONObject:[model mj_keyValues] options:NSJSONWritingPrettyPrinted error:nil];
    redirectPart = [SecurityUtil encryptAESData:sourceData]; //不一致更新重定向片段
    
    //1.2 判断是否为h5首页
    //构造重定向地址、web界面地址
    h5Url  = [NSString stringWithFormat:@"%@%@",SERVER_HTTP_BASE, self.funcBaseUrl];
    webUrl = [NSString stringWithFormat:@"%@/appRedirect.jsp?%@",SERVER_HTTP_BASE, redirectPart];
    
    if ([[webView.URL absoluteString] isEqualToString:h5Url]) {
        needReload = YES;
    }
    
    if (needReload) {
        NSURL *URL = [NSURL URLWithString:webUrl];
        if (!URL) {
            return;
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
        
        [webView loadRequest:request];
        
        needReload = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkPhotoAuthorization];
    [self checkCameraAuthorization];
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

- (void)openLoginVC {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    NSString *urlScheme = [Util getURLScheme];
    
    NSLog(@"zhccc--- 发送请求前：URL=%@",urlString);
    
    //拦截跳转到入口界面的上一级界面
    urlString = [urlString stringByRemovingPercentEncoding];
    if ([urlString isEqualToString:_previosUrl]) {
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [SVProgressHUD show];
    
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 页面开始加载：URL=%@",urlString);
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //    NSString *urlStr = [navigationResponse.response.URL absoluteString];
    //    NSLog(@"zhccc--- 收到响应后：URL=%@",urlStr);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    
    NSString *userName = [Util getUserName];
    lastUserName = userName;
    
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 页面加载完成后：URL=%@",urlString);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
    //    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
    self.navigationController.navigationBar.hidden = NO;
    
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 加载失败：URL=%@",urlString);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 服务器跳转请求：URL=%@",urlString);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 数据加载错误：URL=%@",urlString);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    //    NSString *urlString = [webView.URL absoluteString];
    //    NSLog(@"zhccc--- 进程被终止：URL=%@",urlString);
}


@end
