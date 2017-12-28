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
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"deposit"];
    }
    return self;
}

- (void)excuteRequst:(void (^)(Boolean, float, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            float balance = [[responseDic valueForKey:@"memberBalance"] floatValue];
            complete(YES, balance, nil);
        }
        else {
            complete(NO, 0, errorMsg);
        }
    }];
}

@end
