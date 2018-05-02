//
//  ProductInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductInfo.h"
#import <MJExtension/MJExtension.h>

@implementation ProductInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        [ProductInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"productImages" : @"ProductImageInfo"
                     };
        }];
    }
    return self;
}
@end
