//
//  CheckPhoneExistRequest.h
//  weidong
//
//  Created by zhccc on 2018/3/30.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface CheckPhoneExistRequest : RequestBase
@property(nonatomic, copy)NSString *mobile;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
