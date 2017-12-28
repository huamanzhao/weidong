//
//  GetPointsLogRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetPointsLogResponse : NSObject
@property(nonatomic, copy)NSArray *list;
@end


@interface GetPointsLogRequest : RequestBase
@property(nonatomic, assign)NSInteger pageNumber; //页码
@property(nonatomic, assign)NSInteger pageSize; //每页记录数

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetPointsLogResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
