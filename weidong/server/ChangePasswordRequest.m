//
//  ChangePasswordRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ChangePasswordRequest.h"

@implementation ChangePasswordRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"updateMyPassword"];
    }
    
    return self;
}

//-(void)generateParameterDic {
//    self.paramDic =@{@"currentPassword" : [self.currentPassword md5String], @"password" : self.password};
//}

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
