//
//  ProductDetail.m
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductDetail.h"
#import <MJExtension/MJExtension.h>

@implementation ProductDetail
- (instancetype)init {
    self = [super init];
    if (self) {
        [ProductDetail mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"parameterValues" : @"ProductParameter",
                     @"specificationItems" : @"ProductSpec",
                     @"appSkus" : @"ProductSkuInfo",
                     @"promotions" : @"PromotionInfo",
                     @"productImages" : @"ProductImageInfo"
                     };
        }];
    }
    return self;
}

@end
