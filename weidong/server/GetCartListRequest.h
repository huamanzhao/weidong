//
//  GetCartListRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "CartTypeInfo.h"
#import "CartItemInfo.h"

@interface GetCartListResponse : NSObject
@property (nonatomic, strong) CartTypeInfo *bsDetail; //保税
@property (nonatomic, strong) CartTypeInfo *dmDetail; //大贸
@property (nonatomic, strong) CartTypeInfo *zyDetail; //直邮
@end

@interface GetCartListRequest : RequestBase
- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetCartListResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
