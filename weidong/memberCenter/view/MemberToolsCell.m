//
//  MemberToolsCell.m
//  weidong
//
//  Created by zhccc on 2017/11/6.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberToolsCell.h"

@implementation MemberToolsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [_couponBtn adjustItemsUpDown];
//    [_exchangeBtn adjustItemsUpDown];
    [_creditBtn adjustItemsUpDown];
    [_chargeBtn adjustItemsUpDown];
    [_myCoinBtn adjustItemsUpDown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)myCouponBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    [_delegate showMyCoupons];
}

- (IBAction)exchangeCouponBtnPressed:(id)sender {
}

- (IBAction)myCreditBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    [_delegate showMyCredits];
}

- (IBAction)chargeCouponBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    [_delegate chargeWeidongCoin];
}

- (IBAction)myCoinsBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    [_delegate showMyWeidongCoins];
}

@end
