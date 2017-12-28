//
//  GetProductConsultRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetProductConsultResponse : NSObject
@property(nonatomic, copy)NSArray *_Nullable list;
@end


@interface GetProductConsultRequest : RequestBase
@property(nonatomic, copy)NSString *_Nullable productId;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetProductConsultResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
