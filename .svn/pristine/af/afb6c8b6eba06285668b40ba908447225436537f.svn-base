//
//  GetPromotionRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetPromotionRequest.h"
#import "PromotionInfo.h"

@implementation GetPromotionResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetPromotionResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"PromotionInfo",
                     };
        }];
    }
    return self;
}
@end

@implementation GetPromotionRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getPromotions"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^ _Nonnull)(BOOL isOK, GetPromotionResponse *_Nullable response, NSString *_Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetPromotionResponse *response = [GetPromotionResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
