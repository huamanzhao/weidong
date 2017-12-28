//
//  GetProductCommentRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetProductCommentResponse : NSObject
@property(nonatomic, copy)NSArray *_Nullable list;
@end


@interface GetProductCommentRequest : RequestBase
@property(nonatomic, copy)NSString *_Nullable productId;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetProductCommentResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
