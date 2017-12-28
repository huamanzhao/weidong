//
//  GetHotSearchRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetHotSearchRequest.h"

@implementation GetHotSearchRequest
-(instancetype)init {
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getHotSearches"];
    }
    
    return self;
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSArray* _Nullable list, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            NSArray *list = [responseDic valueForKey:@"list"];
            
            complete(YES, list, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
