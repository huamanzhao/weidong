//
//  GetCategoryProductListRequest.h
//  weidong
//
//  Created by zhccc on 2017/10/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
#import "Enum.h"

@interface GetProductListResponse : NSObject
@property(nonatomic, copy)NSArray *_Nullable list;
@end

@interface GetCategoryProductListRequest : RequestBase
@property(nonatomic, copy)NSString *productCategoryId;  //商品分类ID   bt 必填
@property(nonatomic, copy)NSString *brandId;            //品牌ID      fbt 非必填
@property(nonatomic, copy)NSString *promotionId;        //促销ID      fbt
@property(nonatomic, copy)NSString *productTabId;       //商品标签ID   fbt
@property(nonatomic, assign)ProductSaleType type;       //商品类型     fbt
@property(nonatomic, copy)NSString *startPrice;         //最低价       fbt
@property(nonatomic, copy)NSString *endPrice;           //最高价       fbt
@property(nonatomic, assign)ProductOrderType orderType; //排序类型      bt
@property(nonatomic, assign)ProductCategory productType;//商品类型
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, copy)NSString *productSupplierId;  //供应商ID

- (void)excuteRequest:(void (^_Nonnull)(BOOL isOK, GetProductListResponse * _Nullable response, NSString * _Nullable errorMsg))complete;
@end
