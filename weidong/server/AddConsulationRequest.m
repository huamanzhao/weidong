//
//  AddConsulationRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "AddConsulationRequest.h"

@implementation AddConsulationRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"addConsultation"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}

@end
