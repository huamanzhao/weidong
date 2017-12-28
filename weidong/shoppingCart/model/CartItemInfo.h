//
//  CartItemInfo.h
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//
//  购物车商品小项

#import <Foundation/Foundation.h>

@interface CartItemInfo : NSObject
@property(nonatomic, copy)NSString *productName;    //商品名称
@property(nonatomic, copy)NSString *productId;      //商品ID
@property(nonatomic, copy)NSString *skuName;        //sku名称
@property(nonatomic, copy)NSString *skuId;          //商品skuid
@property(nonatomic, copy)NSString *skuThumbnail;   //商品缩略图
@property(nonatomic, copy)NSString *skuPath;        //商品WEB链接地址
@property(nonatomic, copy)NSString *price;          //价格
@property(nonatomic, copy)NSString *subtotal;       //价格小计
@property(nonatomic, assign)NSInteger quantity;     //数量
@property(nonatomic, assign)ProductCategory productType; //商品类型

- (void)addLocalRecord; //保存到本地
- (void)updateLocalRecord;  //更新本地记录
- (void)removeLocalRecord;  //删除本地记录
- (void)uploadToServer:(void (^_Nonnull)(BOOL))complete;    //同步到服务器

//保存单个的
+ (void)recordCart:(CartItemInfo *)cartInfo;
//保存列表
+ (void)recordCartList:(NSArray *)cartList;
//读取本地购物车列表
+ (NSArray *)getLocalCartList;
//清空本地
+ (void)clearLocalRecords;

@end
