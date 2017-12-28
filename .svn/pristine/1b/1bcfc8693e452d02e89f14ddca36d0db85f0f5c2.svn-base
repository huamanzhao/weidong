//
//  SelfInfo.m
//  weidong
//
//  Created by zhccc on 2017/10/31.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "SelfInfo.h"
#import <MJExtension/MJExtension.h>

#define DEFAULT_SELF @"default_selfInfo"

@implementation SelfInfo

+ (NSDictionary *)localSelfInfoDic {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *selfDic = [userDefault valueForKey:DEFAULT_SELF];
    
    return selfDic;
}

+ (SelfInfo *)localSelfInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *selfDic = [userDefault valueForKey:DEFAULT_SELF];
    if (selfDic == nil) {
        return nil;
    }
    
    SelfInfo *info = [SelfInfo mj_setKeyValues:selfDic];
    
    return info;
}

- (void)recordToLocal {
    NSDictionary *selfDic = [self mj_keyValues];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:selfDic forKey:DEFAULT_SELF];
    [userDefault synchronize];
}

+ (void)clearLocalInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:DEFAULT_SELF];
    [userDefault synchronize];
}

@end
