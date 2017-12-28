//
//  GetConsulationRequest.h
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetConsulationResponse : NSObject
@property (nonatomic, copy) NSArray *list;
@end


@interface GetConsulationRequest : RequestBase
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger pageSize;

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetConsulationResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
