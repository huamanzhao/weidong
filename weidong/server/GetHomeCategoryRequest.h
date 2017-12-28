//
//  GetHomeCategoryRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"

@interface GetCategoryResponse : NSObject

@property(nonatomic, strong)NSMutableArray *_Nullable list;

@end



@interface GetHomeCategoryRequest : RequestBase

- (void)excuteRequest:(void (^ _Nonnull)(BOOL isOK, GetCategoryResponse *_Nullable response, NSString *_Nullable errorMsg))complete;

@end
