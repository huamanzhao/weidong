//
//  GetCouponListRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/25.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetCouponListResponse : NSObject
@property (nonatomic, copy) NSArray *list;
@end

@interface GetCouponListRequest : RequestBase
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetCouponListResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
