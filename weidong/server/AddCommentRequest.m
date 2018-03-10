//
//  AddCommentRequest.m
//  weidong
//
//  Created by zhccc on 2018/3/10.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "AddCommentRequest.h"

@implementation AddCommentRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"addReview"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        complete(isOK, errorMsg);
    }];
}
@end
