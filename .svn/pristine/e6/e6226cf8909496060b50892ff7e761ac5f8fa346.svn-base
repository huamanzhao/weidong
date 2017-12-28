//
//  AddProductNotifyReqeust.m
//  weidong
//
//  Created by zhccc on 2017/12/24.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "AddProductNotifyReqeust.h"

@implementation AddProductNotifyReqeust
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([Util userIsLogin]) {
            self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"saveProductNotify"];
        }
        else {
            self.urlString = [SERVER_API_URL stringByAppendingString:@"saveProductNotify"];
        }
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSString *))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}

@end
