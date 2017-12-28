//
//  GetProductDetailRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "ProductDetail.h"

@interface GetProductDetailResponse : NSObject
@property(nonatomic, strong)ProductDetail *_Nullable detail;
@property(nonatomic, copy)NSArray *promotions;  //促销列表;
@end

@interface GetProductDetailRequest : RequestBase
@property(nonatomic, copy)NSString *_Nullable productId;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetProductDetailResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
