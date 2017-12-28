//
//  ProductSearchRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductSearchRequest.h"

@implementation ProductSearchResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [ProductSearchResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ProductInfo",
                     };
        }];
    }
    
    return self;
}
@end


@implementation ProductSearchRequest

-(instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"search"];
        
        self.orderType = OrderType_Init;
    }
    
    return self;
}

-(void)generateParameterDic {
    NSMutableDictionary *tempDic = [self mj_keyValues];
    if (self.orderType == OrderType_Init) {
        [tempDic removeObjectForKey:@"orderType"];
    }
    self.paramDic = [tempDic copy];
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, ProductSearchResponse* _Nullable response, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            ProductSearchResponse *response = [ProductSearchResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}
@end
