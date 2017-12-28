//
//  GetBannerAdsRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetBannerAdsRequest.h"

@implementation GetBannerAdsResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetBannerAdsResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"AdInfo",
                     };
        }];
    }
    return self;
}
@end

@implementation GetBannerAdsRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getAds"];
        
        self.adPosition = AdPostion_Init;
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetBannerAdsResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetBannerAdsResponse *response = [GetBannerAdsResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
