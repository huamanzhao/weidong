//
//  PaymentPluginInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/30.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "PaymentPluginInfo.h"
#import <MJExtension/MJExtension.h>

@implementation PaymentPluginInfo
- (instancetype)init {
    self = [super init];
    if (self) {
        [PaymentPluginInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"descript" : @"description"
                     };
        }];
    }
    return self;
}
@end
