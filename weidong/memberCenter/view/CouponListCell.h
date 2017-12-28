//
//  CouponListCell.h
//  weidong
//
//  Created by zhccc on 2017/12/25.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponInfo.h"

#define COUPON_CELLID @"CouponCellIdentifier"

@interface CouponListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbLabel;
@property (weak, nonatomic) IBOutlet UILabel *useDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *expireLabel;
@property (weak, nonatomic) IBOutlet UILabel *usedLabel;
@property (weak, nonatomic) IBOutlet UIButton *userBtn;


- (void)setupWithCoupon:(CouponInfo *)coupon;
@end
