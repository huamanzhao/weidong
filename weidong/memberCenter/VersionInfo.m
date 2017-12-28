//
//  VersionInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "VersionInfo.h"
#import <MJExtension/MJExtension.h>

@implementation VersionInfo

-(instancetype)init {
    self = [super init];
    
    if (self) {
        [VersionInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"descript" : @"description"
                     };
        }];
    }
    
    return self;
}

@end
