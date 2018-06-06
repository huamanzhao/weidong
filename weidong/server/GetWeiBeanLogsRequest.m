//
//  GetWeiBeanLogsRequest.m
//  weidong
//
//  Created by zhccc on 2018/6/3.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "GetWeiBeanLogsRequest.h"
#import "GetCoinsLogRequest.h"

@implementation GetWeiBeanLogsRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getDepositCodes"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSArray * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetCoinsLogResponse *response = [GetCoinsLogResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response.list, nil);
    }];
}

@end
