//
//  GetMemberInfoRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetMemberInfoRequest.h"

@implementation GetMemberInfoRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getMemberIndex"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, MemberLoginInfo * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            MemberLoginInfo *member = [MemberLoginInfo mj_objectWithKeyValues:responseDic];
            complete(YES, member, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
