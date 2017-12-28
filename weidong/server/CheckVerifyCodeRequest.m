//
//  CheckVerifyCodeRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CheckVerifyCodeRequest.h"

@implementation CheckVerifyCodeRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"checkVerifyCode"];
        self.type = VerifyCodeType_Init;
    }
    
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"type": [NSString stringWithFormat:@"%ld", (long)self.type],
                      @"imei": [Util getDeviceUUID],
                      @"verifyCode" : self.verifyCode
                      };
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * _Nullable errorMsg))complete {
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
