//
//  VerifySmsCodeRequest.h
//  weidong
//
//  Created by zhccc on 2018/3/8.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface VerifySmsCodeRequest : RequestBase
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *verifyCode;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
