//
//  GetProductNotifyRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/24.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetProductNotifyRequest.h"

@implementation GetProductNotifyResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetProductNotifyResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ArrivalNoticeInfo"
                     };
        }];
    }
    return self;
}
@end

@implementation GetProductNotifyRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getProductNotify"];
    }
    return self;
}

- (void)excuteRequest:(void(^ _Nonnull)(BOOL isOK, GetProductNotifyResponse *, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetProductNotifyResponse *response = [GetProductNotifyResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, nil);
    }];
}

@end
