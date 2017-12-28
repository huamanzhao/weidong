//
//  ResetPasswordRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface ResetPasswordRequest : RequestBase
@property(nonatomic, copy)NSString *mobile;     //用户名
@property(nonatomic, copy)NSString *verifyCode; //验证码
@property(nonatomic, copy)NSString *password;   //新密码

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
