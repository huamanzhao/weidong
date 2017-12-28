//
//  PayOrderReqeust.m
//  weidong
//
//  Created by zhccc on 2017/10/9.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "PayOrderReqeust.h"

@implementation PayOrderReqeust

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"goOrderCheckout"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSDictionary * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            
            complete(YES, responseDic, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}
@end
