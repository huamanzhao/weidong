//
//  CheckRealIdentifyRequest.h
//  weidong
//
//  Created by zhccc on 2017/11/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface CheckRealIdentifyRequest : RequestBase
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *cardNo;

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, NSString * _Nullable errorMsg))complete;
@end
