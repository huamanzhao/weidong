//
//  OrderProductInfo.h
//  weidong
//
//  Created by zhccc on 2017/12/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderProductInfo : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, assign)float price;
@property(nonatomic, assign)NSInteger quantity;
@property(nonatomic, copy)NSString *thumbnail;
@end
