//
//  LoginRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "LoginRequest.h"
#import "Util.h"

@implementation LoginRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"login"];
    }
    
    return self;
}

- (void)generateParameterDic {
    self.password = [self.password md5String];
    
    NSMutableDictionary *tempDic = self.mj_keyValues;
    [tempDic setValue:[Util getDeviceVersion] forKey:@"phone_model"];
    [tempDic setValue:[Util getSystemVerison] forKey:@"phone_system"];
    [tempDic setValue:[Util getDeviceUUID] forKey:@"login_imei"];
    [tempDic setValue:[[NSDate localDate] toString:@"yyyymmddhhmmss"] forKey:@"login_time"];
    
    self.paramDic = [tempDic copy];
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * token, NSString *expireTime, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            NSString *token = [responseDic valueForKey:@"access_token"];
            NSString *expireTime = [responseDic valueForKey:@"expires_time"];
            
            //修改登录状态
            [Util setUserLogin:YES];
            
            complete(YES, token, expireTime, nil);
        }
        else {
            complete(NO, nil, nil, errorMsg);
        }
    }];
}

@end
