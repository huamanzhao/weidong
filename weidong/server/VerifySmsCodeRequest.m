//
//  VerifySmsCodeRequest.m
//  weidong
//
//  Created by zhccc on 2018/3/8.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "VerifySmsCodeRequest.h"

@implementation VerifySmsCodeRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"verifySmsVerifyCode"];
    }
    return self;
}

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}

@end
