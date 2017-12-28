//
//  GetVerifyCodeRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetVerifyCodeRequest.h"

@implementation GetVerifyCodeRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getVerifyCode"];
        
        self.type = VerifyCodeType_Init;
    }
    
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"type": [NSString stringWithFormat:@"%ld", self.type],
                      @"imei": [Util getDeviceUUID]
                      };
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * verifyCode, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            NSString *verifyCode = [responseDic valueForKey:@"verifyCode"];
            
            complete(YES, verifyCode, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
