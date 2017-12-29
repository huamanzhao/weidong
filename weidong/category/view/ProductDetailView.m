//
//  ProductDetailView.m
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductDetailView.h"
#import <WebKit/WebKit.h>

@implementation ProductDetailView {
    WKWebView *webView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ProductDetailView" owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    webView = [[WKWebView alloc] initWithFrame:self.bounds];
    webView.contentMode = UIViewContentModeScaleAspectFit;
    [_scroll addSubview:webView];
    
    //下拉切换页面
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.delegate) {
            [self.delegate showProductHome];
        }
        [_scroll.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉切换页面" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换页面" forState:MJRefreshStateRefreshing];
    _scroll.mj_header = header;
    
    //上拉切换页面
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (_delegate) {
            [_delegate showProductComments];
        }
        [_scroll.mj_footer endRefreshing];
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"上拉切换页面" forState:MJRefreshStatePulling];
    [footer setTitle:@"上拉切换页面" forState:MJRefreshStateRefreshing];
    _scroll.mj_footer = footer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    webView.frame = self.bounds;
}


- (void)setupWithProductDetail:(ProductDetail *)detail {
    if (!detail) {
        return;
    }
    if (STRING_NULL(detail.introduction)) {
        return;
    }
    
    NSString * htmlStyle = @" <style type=\"text/css\"> img{ width: 100%; height: auto; display: block; } </style> ";
    NSString * htmlStr = detail.introduction;
    htmlStr = [htmlStr stringByAppendingString:htmlStyle];
    
    [webView loadHTMLString:htmlStr baseURL:nil];
}

@end
