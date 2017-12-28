//
//  ReturnOrderRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/9.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ReturnOrderRequest.h"

@implementation ReturnOrderRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"returnOrder"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSDictionary * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            
            complete(YES, responseDic, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
