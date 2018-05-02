//
//  ProductInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum.h"

@interface ProductInfo : NSObject

@property(nonatomic, copy)NSString *id;     //商品id
@property(nonatomic, copy)NSString *sn;     //商品编号
@property(nonatomic, copy)NSString *name;   //商品名称
@property(nonatomic, copy)NSString *caption;//商品副标题
@property(nonatomic, assign)ProductSaleType type;   //商品类型  普通商品、兑换商品、赠品
@property(nonatomic, assign)ProductCategory productType; //商品类别 保税、大贸、直邮
@property(nonatomic, copy)NSString *image;   //图片地址
@property(nonatomic, assign)float price;
@property(nonatomic, copy)NSString *introduction;
@property(nonatomic, copy)NSArray *productImages;
@end
