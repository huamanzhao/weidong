//
//  UpdateCardInfoRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface UpdateCardInfoRequest : RequestBase
@property (copy, nonatomic) NSString *skuId;
@property (nonatomic, assign) NSInteger quantity;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
