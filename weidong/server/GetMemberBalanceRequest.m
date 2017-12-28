//
//  GetMemberBalanceRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetMemberBalanceRequest.h"
#import <MJExtension/MJExtension.h>
@implementation GetMemberBalanceResponse
-(instancetype)init {
    self = [super init];
    if (self) {
        [GetMemberBalanceResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"paymentPlugins" : @"PaymentPluginInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetMemberBalanceRequest
- (instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"myMemberBalance"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetMemberBalanceResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetMemberBalanceResponse *response = [GetMemberBalanceResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
