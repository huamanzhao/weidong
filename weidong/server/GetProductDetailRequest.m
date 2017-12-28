//
//  GetProductDetailRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetProductDetailRequest.h"

@implementation GetProductDetailResponse
@end


@implementation GetProductDetailRequest
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getProductDetail"];
    }
    
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"id" : self.productId};
}

- (void)excuteRequest:(void (^)(BOOL, GetProductDetailResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetProductDetailResponse *response = [GetProductDetailResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}
@end
