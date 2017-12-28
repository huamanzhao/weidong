//
//  FavoriteProductInfo.h
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteProductInfo : NSObject
@property(nonatomic, copy)NSString *id;     //收藏ID
@property(nonatomic, copy)NSString *memberId;     //用户ID
@property(nonatomic, copy)NSString *memberName;   //用户姓名
@property(nonatomic, copy)NSString *productId;     //商品id
@property(nonatomic, copy)NSString *productSn;     //商品编号
@property(nonatomic, copy)NSString *productName;   //商品名称
@property(nonatomic, copy)NSString *productCaption;//商品副标题
@property(nonatomic, assign)ProductSaleType type;   //商品类型  普通商品、兑换商品、赠品
@property(nonatomic, assign)ProductCategory productType; //商品类别 保税、大贸、直邮
@property(nonatomic, copy)NSString *productImage;   //图片地址
@property(nonatomic, assign)float productPrice;
@property(nonatomic, copy)NSString *productIntroduction;
@end
