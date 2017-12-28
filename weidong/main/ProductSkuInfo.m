//
//  ProductSkuInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductSkuInfo.h"
#import <MJExtension/MJExtension.h>

@implementation ProductSkuInfo
- (instancetype)init {
    self = [super init];
    if (self) {
        [ProductSkuInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"specificationValues" : @"ProductSpecValue"
                     };
        }];
    }
    return self;
}
@end
