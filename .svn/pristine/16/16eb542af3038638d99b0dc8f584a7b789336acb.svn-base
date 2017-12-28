//
//  CheckVersionRequest.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CheckVersionRequest.h"

@implementation CheckVersionResponse

-(instancetype)init {
    self = [super init];
    if (self) {
        [CheckVersionResponse mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"version" : @"VersionInfo",
                     };
        }];
    }
    return self;
}
@end



@implementation CheckVersionRequest

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.urlString = [SERVER_API_URL stringByAppendingString:@"checkVersion"];
    }
    
    return self;
}

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, CheckVersionResponse* _Nullable  response, NSString * _Nullable errorMsg))complete {
    [self doRequest:^(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg) {
        if (isOK) {
            CheckVersionResponse *response = [CheckVersionResponse mj_objectWithKeyValues:responseDic];
            complete(YES, response, nil);
        }
        else {
            complete(NO, nil, errorMsg);
        }
    }];
}

@end
