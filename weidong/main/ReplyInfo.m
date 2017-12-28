//
//  ReplyInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ReplyInfo.h"
#import <MJExtension/MJExtension.h>

@implementation ReplyInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        [ReplyInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"replyAppConsultations" : @"ReplyInfo"
                     };
        }];
    }
    return self;
}
@end
