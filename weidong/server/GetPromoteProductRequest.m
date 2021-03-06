//
//  GetPromoteProductRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetPromoteProductRequest.h"
@implementation GetPromoteProductResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetPromoteProductResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ProductInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetPromoteProductRequest
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getProductsByPromotionId"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetPromoteProductResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetPromoteProductResponse *response = [GetPromoteProductResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
