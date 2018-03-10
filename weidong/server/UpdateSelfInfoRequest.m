//
//  UpdateSelfInfoRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "UpdateSelfInfoRequest.h"

@implementation UpdateSelfInfoRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"updateMyInfo"];
    }
    
    return self;
}

- (void)generateParameterDic {
    NSMutableDictionary *tempDic = [NSMutableDictionary new];
    [tempDic setValue:_info.nickname forKey:@"nickname"];
    [tempDic setValue:_info.email forKey:@"email"];
    [tempDic setValue:_info.mobile forKey:@"mobile"];
    [tempDic setValue:_info.phone forKey:@"phone"];
    [tempDic setValue:_info.memberAttribute_1 forKey:@"memberAttribute_1"];
    [tempDic setValue:_info.memberAttribute_51 forKey:@"memberAttribute_51"];
    
    self.paramDic = [tempDic copy];
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
