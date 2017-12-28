//
//  SendSmsVerifycodeRequest.h
//  weidong
//
//  Created by zhccc on 2017/11/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface SendSmsVerifycodeRequest : RequestBase
@property(nonatomic, copy)NSString *mobile;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;

@end
