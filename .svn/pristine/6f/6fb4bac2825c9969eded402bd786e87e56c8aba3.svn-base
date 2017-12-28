//
//  GetOrderListRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/9.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetOrderListRequest.h"

@implementation GetOrderListResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetOrderListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"OrderListInfo"
                     };
        }];
    }
    return self;
}
@end


@implementation GetOrderListRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getOrders"];
        self.status = OrderType_Init;
    }
    
    return self;
}

- (void)generateParameterDic {
    NSMutableDictionary *tempDic = [self mj_keyValues];
    if (self.status == OrderType_Init) {
        [tempDic removeObjectForKey:@"status"];
    }
    self.paramDic = [tempDic copy];
}

- (void)excuteRequest:(void (^)(BOOL, GetOrderListResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetOrderListResponse *response = [GetOrderListResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
