//
//  LoginRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface LoginRequest : RequestBase

@property(nonatomic, copy)NSString *_Nonnull login_name;     //用户名
@property(nonatomic, copy)NSString *_Nonnull password;       //密码

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * token, NSString *expireTime, NSString * _Nullable errorMsg))complete;

@end
