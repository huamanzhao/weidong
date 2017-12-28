//
//  RegisterRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"register"];
    }
    
    return self;
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
