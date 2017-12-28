//
//  GetProductConsultRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "GetProductConsultRequest.h"
#import <MJExtension/MJExtension.h>

@implementation GetProductConsultResponse
-(instancetype)init {
    self = [super init];
    if (self) {
        [GetProductConsultResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list" : @"ConsultationInfo",
                     };
        }];
    }
    return self;
}
@end


@implementation GetProductConsultRequest

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"getProductConsultations"];
    }
    
    return self;
}

- (void)generateParameterDic {
    self.paramDic = @{@"id" : self.productId};
}

- (void)excuteRequest:(void (^)(BOOL, GetProductConsultResponse * _Nullable, NSString * _Nullable))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            GetProductConsultResponse *reponse = [GetProductConsultResponse mj_objectWithKeyValues:responseDic];
            complete(YES, reponse, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
