//
//  GetArticalDetailRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetArticalDetailRequest.h"


@implementation GetArticalDetailRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getArticleDetail"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, ArticalInfo * _Nullable artical, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            NSDictionary *articalDic = [responseDic objectForKey:@"detail"];
            ArticalInfo *artical = [ArticalInfo mj_objectWithKeyValues:articalDic];
            complete(YES, artical, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
