//
//  ProductParameter.m
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductParameter.h"
#import <MJExtension/MJExtension.h>

@implementation ProductParameter
- (instancetype)init {
    self = [super init];
    if (self) {
        [ProductParameter mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"entries" : @"ParameterInfo"
                     };
        }];
    }
    return self;
}
@end
