//
//  ResetPasswordRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ResetPasswordRequest.h"

@implementation ResetPasswordRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"resetPassword"];
    }
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"mobile" : self.mobile, @"verifyCode" : self.verifyCode, @"newPassword" : self.password};
}

- (void)excuteRequest:(void (^)(BOOL, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            complete(YES, nil);
        }
        else {
            complete(NO, errorMsg);
        }
    }];
}

@end
