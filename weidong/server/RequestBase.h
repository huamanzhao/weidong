//
//  RequestBase.h
//  GZDefence
//
//  Created by zhccc on 2017/8/19.
//  Copyright © 2017年 wxy. All rights reserved.
//  网络请求基类

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "Constants.h"
#import "Enum.h"

@interface RequestBase : NSObject

@property(nonatomic, copy)NSDictionary * _Nullable paramDic;    //参数字典
@property(nonatomic, copy)NSString * _Nullable urlString;       //地址
@property(nonatomic, copy)NSString * _Nullable reqType;         //请求类型： GET/POST
@property(nonatomic, assign)NSTimeInterval timeoutInterval;     //超时时长

- (void)generateParameterDic;       //参数字典
- (void)doRequest:(void (^_Nonnull)(Boolean isOK, NSDictionary * _Nullable responseDic, NSString * _Nullable errorMsg))complete;

@end
