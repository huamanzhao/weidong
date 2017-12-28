//
//  AdvertisementViewController.m
//  weidong
//
//  Created by zhccc on 2017/10/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "AdvertisementViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "Util.h"
#import "GetArticalDetailRequest.h"

@interface AdvertisementViewController ()

@end

@implementation AdvertisementViewController {
    WKWebView *webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBackButton];
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20)];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (STRING_NULL(_articleId)) {
        [self getAdArtical];
    }
    else if (_artical) {
        [self loadArticalContent:_artical];
    }
}

- (void)getAdArtical {
    if (STRING_NULL(_articleId)) {
        [SVProgressHUD showErrorWithStatus:@"传入参数错误"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    GetArticalDetailRequest *request = [GetArticalDetailRequest new];
    request.articleId = _articleId;
    [request excuteRequest:^(BOOL isOK, ArticalInfo * _Nullable artical, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [self loadArticalContent:artical];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"获取文章失败"];
        }
    }];
}

- (void)loadArticalContent: (ArticalInfo *)artical {
    if (!artical) {
        [SVProgressHUD showErrorWithStatus:@"获取文章数据为空"];
        return;
    }
    
    [webView loadHTMLString:artical.content baseURL:nil];
}

@end
