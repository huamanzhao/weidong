//
//  GetProductCommentRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetProductCommentRequest.h"

@implementation GetProductCommentResponse
-(instancetype)init {
    self = [super init];
    if (self) {
        [GetProductCommentResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CommentInfo",
                     };
        }];
    }
    return self;
}
@end

@implementation GetProductCommentRequest
- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getProductReviews"];
    }
    
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"id" : self.productId};
}

- (void)excuteRequest:(void (^)(BOOL, GetProductCommentResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetProductCommentResponse *response = [GetProductCommentResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
