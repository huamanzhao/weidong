//
//  DeliverAddressInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/31.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeliverAddressInfo : NSObject
@property(nonatomic, copy)NSString *id;         //地址主键
@property(nonatomic, copy)NSString *consignee;  //收货人
@property(nonatomic, copy)NSString *areaName;   //地区名称
@property(nonatomic, copy)NSString *address;    //地址
@property(nonatomic, copy)NSString *zipCode;    //邮编
@property(nonatomic, copy)NSString *phone;      //电话
@property(nonatomic, assign)BOOL isDefault;     //是否默认
@property(nonatomic, copy)NSString *areaId;     //地区编码

@property(nonatomic, copy)NSString *provinceAreaName;
@property(nonatomic, copy)NSString *cityAreaName;
@property(nonatomic, copy)NSString *countyAreaName;

@property(nonatomic, copy)NSString *areaGrade;
@property(nonatomic, copy)NSString *provinceFullAreaName;
@property(nonatomic, copy)NSString *cityFullAreaName;
@property(nonatomic, copy)NSString *countyFullAreaName;
@property(nonatomic, copy)NSString *provinceAreaId;
@property(nonatomic, copy)NSString *cityAreaId;
@property(nonatomic, copy)NSString *countyAreaId;

@end
