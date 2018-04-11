//
//  GetCategoryProductListRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetCategoryProductListRequest.h"
#import <MJExtension/MJExtension.h>

@implementation GetProductListResponse
-(instancetype)init {
    self = [super init];
    if (self) {
        [GetProductListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ProductInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetCategoryProductListRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getProductList"];
        
        self.orderType = OrderType_Init;
        self.type = ProductSaleType_Init;
        self.productType = ProductType_Init;
    }
    
    return self;
}

- (void)generateParameterDic {
    NSMutableDictionary *tempDic = [self mj_keyValues];
    if (self.orderType == OrderType_Init) {
        [tempDic removeObjectForKey:@"orderType"];
    }
    if (self.type == ProductSaleType_Init) {
        [tempDic removeObjectForKey:@"type"];
    }
    if (self.productType == ProductType_Init) {
        [tempDic removeObjectForKey:@"productType"];
    }
    self.paramDic = [tempDic copy];
}


- (void)excuteRequest:(void (^)(BOOL, GetProductListResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetProductListResponse *reponse = [GetProductListResponse mj_objectWithKeyValues:responseDic];
            complete(YES, reponse, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
