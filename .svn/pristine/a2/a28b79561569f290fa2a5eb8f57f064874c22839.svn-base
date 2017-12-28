//
//  OrderListInfo.m
//  weidong
//
//  Created by zhccc on 2017/12/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "OrderListInfo.h"
#import <MJExtension/MJExtension.h>

@implementation OrderListInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        [OrderListInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"orderItems" : @"OrderProductInfo"
                     };
        }];
    }
    return self;
}
@end
