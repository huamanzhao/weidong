//
//  GetCommentLIstRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetCommentListResponse : NSObject
@property (nonatomic, copy) NSArray *list;
@end

@interface GetCommentLIstRequest : RequestBase
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetCommentListResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
