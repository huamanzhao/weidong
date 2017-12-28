//
//  CheckVersionRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "VersionInfo.h"

@interface CheckVersionResponse : NSObject
@property(nonatomic, assign)BOOL is_need_update;
@property(nonatomic, weak)VersionInfo* _Nullable version;
@end



@interface CheckVersionRequest : RequestBase

@property(nonatomic, copy)NSString *_Nonnull version_code;

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, CheckVersionResponse* _Nullable  response, NSString * _Nullable errorMsg))complete;

@end

