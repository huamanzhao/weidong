//
//  AddConsulationRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface AddConsulationRequest : RequestBase
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *content;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
