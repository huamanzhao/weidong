//
//  GetWeiBeanLogsRequest.h
//  weidong
//
//  Created by zhccc on 2018/6/3.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface GetWeiBeanLogsRequest : RequestBase
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg))complete;
@end
