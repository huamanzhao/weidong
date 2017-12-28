//
//  CategoryInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/15.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CategoryInfo.h"
#import <MJExtension/MJExtension.h>
#import "ProductInfo.h"

@implementation CategoryInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        [CategoryInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"productList" : @"ProductInfo",
                     @"childList" : @"CategoryInfo"
                     };
        }];
    }
    return self;
}

@end
