//
//  GetArticalDetailRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "ArticalInfo.h"

@interface GetArticalDetailRequest : RequestBase

@property(nonatomic, copy)NSString *_Nonnull articleId;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, ArticalInfo * _Nullable artical, NSString * _Nullable errorMsg))complete;

@end
