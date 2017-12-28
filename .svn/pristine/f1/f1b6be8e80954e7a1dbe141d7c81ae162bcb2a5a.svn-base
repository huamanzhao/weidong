//
//  ProductSearchRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "Enum.h"

@interface ProductSearchResponse : NSObject
@property(nonatomic, copy)NSArray * _Nullable list;
@end



@interface ProductSearchRequest : RequestBase

@property(nonatomic, assign)ProductOrderType orderType;
@property(nonatomic, copy)NSString *_Nullable keyword;
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;

- (void)excuteRequst:(void (^_Nonnull)(Boolean isOK, ProductSearchResponse* _Nullable response, NSString * _Nullable errorMsg))complete;

@end
