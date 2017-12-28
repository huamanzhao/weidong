//
//  ChangePasswordRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface ChangePasswordRequest : RequestBase
@property(nonatomic, copy)NSString *currentPassword;
@property(nonatomic, copy)NSString *password;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
