//
//  GetAreaListRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
@interface GetAreaListResponse : NSObject
@property(nonatomic, strong)NSArray *list;
@end


@interface GetAreaListRequest : RequestBase
@property(nonatomic, copy)NSString *parentId;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg))complete;
@end
