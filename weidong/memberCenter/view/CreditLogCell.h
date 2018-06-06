//
//  CreditLogCell.h
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditLogInfo.h"
#import "CoinLogInfo.h"

#define CREDITLOG_CELLID @"creditLogIdentifier"

@interface CreditLogCell : UITableViewCell
//积分
- (void)setupCreditTitleStyle;
- (void)setupWithCredit:(CreditLogInfo *)credit Index:(NSInteger)index;

//微动币
- (void)setupCoinTitleStyle;
- (void)setupWithCoin:(CoinLogInfo *)log Index:(NSInteger)index;

@end
