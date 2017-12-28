//
//  GetHomeCategoryRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetHomeCategoryRequest.h"
#import <MJExtension/MJExtension.h>
#import "CategoryInfo.h"

@implementation GetCategoryResponse
- (instancetype)init {
    self = [super init];
    if (self) {
        [GetCategoryResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"CategoryInfo"
                     };
        }];
    }
    return self;
}
@end



@implementation GetHomeCategoryRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getIndexCategorysAndProducts"];
    }
    
    return self;
}

- (void)excuteRequest:(void (^)(BOOL, GetCategoryResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetCategoryResponse *response = [GetCategoryResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
