//
//  EgouCardBDepositRequest.m
//  weidong
//
//  Created by zhccc on 2018/6/6.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "EgouCardBDepositRequest.h"

@implementation EgouCardBDepositRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = SERVER_WEIDOU_URL;
        self.reqType = @"POST";
    }
    return self;
}

- (void)excuteRequst:(void (^)(Boolean, NSString * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        NSString *result = [responseDic objectForKey:@"result"];
        NSString *desc   = [responseDic objectForKey:@"desc"];
        NSString *url    = [responseDic objectForKey:@"url"];
        
        if (![result isEqualToString:@"1"]) {
            complete(NO, nil, desc);
            return;
        }
        
        complete(YES, url, desc);
    }];
}

@end
