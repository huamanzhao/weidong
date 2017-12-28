//
//  GetCoinsLogRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetCoinsLogRequest.h"

@implementation GetCoinsLogResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetCoinsLogResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CoinLogInfo"
                     };
        }];
    }
    return self;
}
@end

@implementation GetCoinsLogRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getDeposits"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetCoinsLogResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetCoinsLogResponse *response = [GetCoinsLogResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, nil);
    }];
}
@end
