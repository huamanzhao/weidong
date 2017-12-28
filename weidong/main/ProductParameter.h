//
//  ProductParameter.h
//  weidong
//
//  Created by zhccc on 2017/10/29.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductParameter : NSObject
@property(nonatomic, copy)NSString *group;  //参数组名
@property(nonatomic, copy)NSArray *entries; //参数列表
@end
