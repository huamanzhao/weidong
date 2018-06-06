//
//  GetCoinsLogRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//
//  微动币查询

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetCoinsLogResponse : NSObject
@property (nonatomic, copy) NSArray *list;
@end

@interface GetCoinsLogRequest : RequestBase
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetCoinsLogResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
