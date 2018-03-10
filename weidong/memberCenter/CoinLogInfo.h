//
//  CoinLogInfo.h
//  weidong
//
//  Created by zhccc on 2017/12/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoinLogInfo : NSObject

@property(nonatomic, copy)NSString *id;     //备注
@property(nonatomic, assign)NSInteger type; //记录类型  0-预存款充值 1-预存款调整 2-订单支付 3-订单退款
@property(nonatomic, assign)float credit;   //收入金额
@property(nonatomic, assign)float debit;    //支出金额
@property(nonatomic, assign)float balance;  //当前余额
@property(nonatomic, copy)NSString *memo;       //备注
@property(nonatomic, copy)NSString *memberId;   //用户ID
@property(nonatomic, copy)NSString *memberName; //用户姓名
@property(nonatomic, copy)NSString *orderSn;    //订单号
@property(nonatomic, copy)NSString *createDate; //创建日期
@end
