//
//  ProductImageInfo.h
//  weidong
//
//  Created by zhccc on 2018/1/8.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductImageInfo : NSObject
@property(nonatomic, copy)NSString *source;
@property(nonatomic, copy)NSString *large;
@property(nonatomic, copy)NSString *medium;
@property(nonatomic, copy)NSString *thumbnail;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, assign)NSInteger order;
@end
