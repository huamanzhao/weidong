//
//  PayManager.m
//  weidong
//
//  Created by zhccc on 2018/1/4.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "PayManager.h"
#import "AppDelegate.h"

@implementation PayManager {
    AppDelegate *app;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        app.wxDelegate = self;
    }
    return self;
}

- (void)payRequest {
    if (!_delegate) {
        return;
    }
    
    PayReq *req = [PayReq new];
    req.partnerId = WX_PartnerID;
    req.prepayId = @"";
    req.nonceStr = @"";
    req.timeStamp = 0;
    req.package = @"Sign=WXPay";
    req.sign = @"";
    [WXApi sendReq:req];
}

- (void)onReq:(BaseReq*)req {
    
}

- (void)onResp:(BaseResp*)resp {
    if (!_delegate) {
        return;
    }
    
    switch (resp.errCode) {
        case 0:
            [_delegate paySucceed];
            break;
            
        case 1:
            [_delegate payFailed:resp.errStr];
            
        case 2:
            [_delegate payCanceled];
            
        default:
            break;
    }
}

@end
