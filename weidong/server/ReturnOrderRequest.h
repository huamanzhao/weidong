//
//  ReturnOrderRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/9.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface ReturnOrderRequest : RequestBase
- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg))complete;
@end
