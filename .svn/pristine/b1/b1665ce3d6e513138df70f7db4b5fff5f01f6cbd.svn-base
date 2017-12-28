//
//  GetCouponListRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/25.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetCouponListRequest.h"

@implementation GetCouponListResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetCouponListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CouponInfo"
                     };
        }];
    }
    return self;
}
@end

@implementation GetCouponListRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getCouponCodes"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetCouponListResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetCouponListResponse *response = [GetCouponListResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, nil);
    }];
}
@end
