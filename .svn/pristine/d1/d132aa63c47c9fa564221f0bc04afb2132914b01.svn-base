//
//  GetConsulationRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetConsulationRequest.h"

@implementation GetConsulationResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetConsulationResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ConsultationInfo",
                     };
        }];
    }
    return self;
}
@end

@implementation GetConsulationRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getConsultationList"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetConsulationResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetConsulationResponse *response = [GetConsulationResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, nil);
    }];
}

@end
