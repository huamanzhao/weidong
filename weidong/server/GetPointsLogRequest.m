//
//  GetPointsLogRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetPointsLogRequest.h"

@implementation GetPointsLogResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetPointsLogResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CreditLogInfo"
                     };
        }];
    }
    return self;
}
@end


@implementation GetPointsLogRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"pointLog"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetPointsLogResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetPointsLogResponse *response = [GetPointsLogResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
