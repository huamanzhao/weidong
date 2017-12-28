//
//  SubmitCartListRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "SubmitCartListRequest.h"

@implementation SubmitCartListRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"submitLocalCarList"];
    }
    return self;
}

- (void)generateParameterDic {
//    NSArray *jsonArray =
}

- (void)excuteRequest:(void (^)(BOOL, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            
            complete(YES, nil);
        }
        else {
            complete(NO, errorMsg);
        }
    }];
}

@end
