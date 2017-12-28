//
//  RefreshTokenReqeust.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface RefreshTokenReqeust : RequestBase

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString  * _Nullable  token, NSString * _Nullable expireTime, NSString * _Nullable errorMsg))complete;

@end
