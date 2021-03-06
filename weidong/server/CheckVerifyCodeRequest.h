//
//  CheckVerifyCodeRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "Enum.h"

@interface CheckVerifyCodeRequest : RequestBase

@property(nonatomic, assign)VerifyCodeType type;
@property(nonatomic, copy)NSString *_Nonnull verifyCode;

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * _Nullable errorMsg))complete;

@end
