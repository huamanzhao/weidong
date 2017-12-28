//
//  GetFavoriteListRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetFavoriteListRequest.h"

@implementation GetFavoriteListResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetFavoriteListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"FavoriteProductInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetFavoriteListRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getProductFavorites"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetFavoriteListResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetFavoriteListResponse *response = [GetFavoriteListResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, errorMsg);
    }];
}

@end
