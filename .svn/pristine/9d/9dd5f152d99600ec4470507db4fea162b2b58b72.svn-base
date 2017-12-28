//
//  CouponListCell.m
//  weidong
//
//  Created by zhccc on 2017/12/25.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CouponListCell.h"

@implementation CouponListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_userBtn setRoundBorder];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithCoupon:(CouponInfo *)coupon {
    if (!coupon) {
        return;
    }
    _nameLabel.text = coupon.name;
    _numbLabel.text = coupon.code;
    _useDataLabel.text = [[coupon.usedDate toDate:@"yyyyMMddHHmmss"] toString:@"yyyy-MM-dd H:m"];
    _expireLabel.text = [[coupon.endDate toDate:@"yyyyMMddHHmmss"] toString:@"yyyy-MM-dd H:m"];
    
    _usedLabel.text = [NSString stringWithFormat:@"是否已使用：%@", coupon.isUsed ? @"是" : @"否"];
}

- (IBAction)usedBtnPressed:(id)sender {
}
@end
