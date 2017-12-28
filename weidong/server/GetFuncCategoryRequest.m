//
//  GetFuncCategoryRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//  获取首页4个功能按钮

#import "GetFuncCategoryRequest.h"

@implementation GetFuncCategoryRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getAfterCategory"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetCategoryResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetCategoryResponse *response = [GetCategoryResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
