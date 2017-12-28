//
//  RemoveFavoriteReqeust.m
//  weidong
//
//  Created by zhouch on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RemoveFavoriteReqeust.h"

@implementation RemoveFavoriteReqeust

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"deleteProductFavorites"];
    }
    return self;
}

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}

@end
