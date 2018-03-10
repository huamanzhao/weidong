//
//  AddCommentRequest.h
//  weidong
//
//  Created by zhccc on 2018/3/10.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "RequestBase.h"

@interface AddCommentRequest : RequestBase
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *score;
@property (nonatomic, copy)NSString *content;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
