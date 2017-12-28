//
//  CreditInfo.h
//  weidong
//
//  Created by zhccc on 2017/10/30.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreditInfo : NSObject
@property(nonatomic, assign)NSInteger type;     //类型    0-积分赠送 1-积分兑换  2-积分兑换撤销 3-积分调整
@property(nonatomic, assign)NSInteger credit;   //获取积分
@property(nonatomic, assign)NSInteger debit;    //扣除积分
@property(nonatomic, assign)NSInteger balance;  //当前积分
@property(nonatomic, copy)NSString *memo;       //备注
@end
