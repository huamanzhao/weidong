//
//  UpdateSelfInfoRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "SelfInfo.h"

@interface UpdateSelfInfoRequest : RequestBase
@property(nonatomic, weak)SelfInfo *info;
- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
