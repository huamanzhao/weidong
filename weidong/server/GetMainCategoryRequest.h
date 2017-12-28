//
//  GetMainCategoryRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetHomeCategoryRequest.h"
#import "RequestBase.h"

@interface GetMainCategoryRequest : RequestBase

- (void)excuteRequest:(void (^ _Nonnull)(BOOL isOK, GetCategoryResponse *_Nullable response, NSString *_Nullable errorMsg))complete;

@end
