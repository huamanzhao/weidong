//
//  GetVerifyCodeRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetVerifyCodeRequest : RequestBase
@property(nonatomic, assign)VerifyCodeType type; //1-注册 2-取回密码 3-登录 4-若有其它往下补充

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * verifyCode, NSString * _Nullable errorMsg))complete;

@end
