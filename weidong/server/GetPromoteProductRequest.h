//
//  GetPromoteProductRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetPromoteProductResponse : NSObject
@property(nonatomic, copy)NSArray *list;
@end


@interface GetPromoteProductRequest : RequestBase
@property(nonatomic, copy)NSString *promotionId;

- (void)excuteRequest:(void (^ _Nonnull)(BOOL isOK, GetPromoteProductResponse *_Nullable response, NSString *_Nullable errorMsg))complete;
@end
