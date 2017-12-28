//
//  MemberToolsCell.h
//  weidong
//
//  Created by zhccc on 2017/11/6.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TOOLS_CELLID @"toolsIdentifier"

@protocol MemberToolsDelegate <NSObject>
- (void)showMyCredits;
- (void)chargeWeidongCoin;
- (void)showMyWeidongCoins;
- (void)showMyCoupons;
@end


@interface MemberToolsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *couponBtn;
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *creditBtn;
@property (weak, nonatomic) IBOutlet UIButton *chargeBtn;
@property (weak, nonatomic) IBOutlet UIButton *myCoinBtn;

@property (weak, nonatomic) id<MemberToolsDelegate> delegate;
@end
