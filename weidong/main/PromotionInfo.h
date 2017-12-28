//
//  PromotionInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/14.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromotionInfo : NSObject

@property(nonatomic, copy)NSString* id;     //促销ID
@property(nonatomic, copy)NSString* name;   //促销名称
@property(nonatomic, copy)NSString* title;   //促销标题
@property(nonatomic, copy)NSString* image;   //图片URL
@property(nonatomic, copy)NSString* introduction; //促销说明
@property(nonatomic, copy)NSString* beginDate;  //开始日期
@property(nonatomic, copy)NSString* endDate;    //结束日期

@end
