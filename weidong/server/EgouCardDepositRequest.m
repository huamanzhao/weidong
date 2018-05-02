//
//  EgouCardDepositRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "EgouCardDepositRequest.h"

@implementation EgouCardDepositRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = SERVER_EGOU_URL;
        self.reqType = @"POST";
    }
    return self;
}

- (void)excuteRequst:(void (^)(Boolean, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, errorMsg);
            return;
        }
        
        NSString *result = [responseDic objectForKey:@"result"];
        NSString *desc   = [responseDic objectForKey:@"desc"];
        
        if (![result isEqualToString:@"1"]) {
            complete(NO, desc);
            return;
        }
        
        complete(YES, desc);
    }];
}

@end
