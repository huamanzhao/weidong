//
//  GetAreaListRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetAreaListRequest.h"

@implementation GetAreaListResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetAreaListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"AreaInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetAreaListRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getAreaList"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSArray * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetAreaListResponse *respose = [GetAreaListResponse mj_objectWithKeyValues:responseDic];
            complete(YES, respose.list, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
