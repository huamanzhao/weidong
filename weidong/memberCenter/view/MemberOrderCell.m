//
//  MemberOrderCell.m
//  weidong
//
//  Created by zhccc on 2017/11/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberOrderCell.h"
#import "BadgeButton.h"

@implementation MemberOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_waitPayBtn adjustItemsUpDown];
    [_waitSendBtn adjustItemsUpDown];
    [_waitReceiveBtn adjustItemsUpDown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithOrderCountsUnpay:(NSInteger)num1 UnSend:(NSInteger)num2 UnReceive:(NSInteger)num3 {
    [_waitPayBtn setBadge:num1];
    [_waitSendBtn setBadge:num2];
    [_waitReceiveBtn setBadge:num3];
}

- (IBAction)waitPayBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate showOrderListWithType:OrderListType_waitPay];
    }
}
- (IBAction)waitsendBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate showOrderListWithType:OrderListType_waitSend];
    }
}
- (IBAction)waitReceiveBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate showOrderListWithType:OrderListType_waitReceive];
    }
}

@end
