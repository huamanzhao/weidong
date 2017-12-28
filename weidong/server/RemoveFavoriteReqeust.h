//
//  RemoveFavoriteReqeust.h
//  weidong
//
//  Created by zhouch on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface RemoveFavoriteReqeust : RequestBase
@property(nonatomic, copy)NSString *id;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, NSString * _Nullable errorMsg))complete;
@end
