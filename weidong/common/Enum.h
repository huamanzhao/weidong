//
//  Enum.h
//  weidong
//
//  Created by zhccc on 2017/10/7.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#ifndef Enum_h
#define Enum_h

typedef NS_ENUM(NSInteger, ProductOrderType) {
    OrderType_Init = -1,    //初始值
    OrderType_TopDesc = 0,  //置顶降序
    OrderType_PriceAsc,     //价格升序
    OrderType_PriceDesc,    //价格降序
    OrderType_SalesDesc,    //销量降序
    OrderType_ScoreDesc,    //评分降序
    OrderType_DateDesc      //日期降序
};

typedef NS_ENUM(NSInteger, ProductSaleType) {
    ProductSaleType_Init = -1,      //初始值
    ProductSaleType_Common = 0,     //普通商品
    ProductSaleType_Exchange = 1,   //兑换商品
    ProductSaleType_Gift = 2        //赠品
};

typedef NS_ENUM(NSInteger, ProductCategory) {
    ProductType_Init = -1,      //初始值
    ProductType_Bonded = 0,     //保税
    ProductType_Trade = 1,      //大贸
    ProductType_Deliver = 2     //直邮
};

typedef NS_ENUM(NSInteger, VerifyCodeType) {
    VerifyCodeType_Init = -1,       //初始值
    VerifyCodeType_Register = 1,    //注册
    VerifyCodeType_Findback,        //取回密码
    VerifyCodeType_Login,           //登录
    VerifyCodeType_Other            //其他 待补充
};

typedef NS_ENUM(NSInteger, AdPostion) {
    AdPostion_Init = -1,    //初始值
    AdPostion_Banner = 51,   //顶部轮播
    AdPostion_Hotspot = 101  //热点广告
};

typedef NS_ENUM(NSInteger, OrderListType) {
    OrderListType_Init = -1,    //初始值
    OrderListType_waitPay = 0,  //待付款   0
    OrderListType_waitCheck,    //等待审核 1
    OrderListType_waitSend,     //待发货   2
    OrderListType_waitReceive,  //待收货   3
    OrderListType_received,     //已收货   4
    OrderListType_done,         //已完成   5
    OrderListType_failed,       //已失败   6
    OrderListType_canceled,     //已取消   7
    OrderListType_denied,       //已拒绝   8
    OrderListType_applySend     //申请发货 9
};

#endif /* Enum_h */
