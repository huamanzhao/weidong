//
//  CheckRealIdentifyRequest.m
//  weidong
//
//  Created by zhccc on 2017/11/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CheckRealIdentifyRequest.h"

@implementation CheckRealIdentifyRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"verifyCardNoAndName"];
    }
    return self;
}

- (void)excuteRequst:(void (^)(Boolean, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}

@end
