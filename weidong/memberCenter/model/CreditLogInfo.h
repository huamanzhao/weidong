//
//  CreditLogInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/30.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditLogInfo : NSObject
@property(nonatomic, assign)NSInteger type;    //类型 0-积分赠送（预存款充值 1-积分兑换（预存款调整） 2-积分兑换撤销（订单支付） 3-积分调整（订单退款）
@property(nonatomic, assign)NSInteger credit;  //获取积分
@property(nonatomic, assign)NSInteger debit;   //扣除积分
@property(nonatomic, assign)NSInteger balance; //当前积分
@property(nonatomic, copy)NSString *memo;      //备注
@property(nonatomic, copy)NSString *memberId;  //用户ID
@property(nonatomic, copy)NSString *memberName;//用户姓名
@end
