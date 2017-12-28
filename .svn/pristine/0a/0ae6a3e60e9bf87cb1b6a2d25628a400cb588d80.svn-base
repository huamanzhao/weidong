//
//  GetProductNotifyRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/24.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface GetProductNotifyResponse : NSObject
@property (nonatomic, copy) NSArray *list;
@end


@interface GetProductNotifyRequest : RequestBase
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;

- (void)excuteRequest:(void(^ _Nonnull)(BOOL isOK, GetProductNotifyResponse *response, NSString * _Nullable errorMsg))complete;
@end
