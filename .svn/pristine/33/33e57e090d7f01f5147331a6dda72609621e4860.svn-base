//
//  GetCommentLIstRequest.m
//  weidong
//
//  Created by zhccc on 2017/12/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetCommentLIstRequest.h"

@implementation GetCommentListResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        [GetCommentListResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CommentInfo",
                     };
        }];
    }
    return self;
}
@end

@implementation GetCommentLIstRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [SERVER_API_URL_MEMEBER stringByAppendingString:@"getReviewList"];
    }
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetCommentListResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (!isOK) {
            complete(NO, nil, errorMsg);
            return;
        }
        
        GetCommentListResponse *response = [GetCommentListResponse mj_objectWithKeyValues:responseDic];
        complete(YES, response, nil);
    }];
}

@end
