//
//  RefreshTokenReqeust.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RefreshTokenReqeust.h"

@implementation RefreshTokenReqeust

- (instancetype)init {
    self = [super init];
    
    self.urlString = [SERVER_API_URL stringByAppendingString:@"refreshToken"];
    
    return self;
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * token, NSString *expireTime, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            NSString *token = [responseDic valueForKey:@"access_token"];
            NSString *expireTime = [responseDic valueForKey:@"expires_time"];
            
            complete(YES, token, expireTime, nil);
        }
        else {
            complete(NO, nil, nil, errorMsg);
        }
    }];
}

@end
