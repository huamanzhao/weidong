//
//  GetOrderListRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/9.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetOrderListResponse : NSObject
@property(nonatomic, copy)NSArray *list;
@end


@interface GetOrderListRequest : RequestBase
@property(nonatomic, assign)OrderListType status;
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetOrderListResponse * _Nullable response, NSString * _Nullable errorMsg))complete;

@end
