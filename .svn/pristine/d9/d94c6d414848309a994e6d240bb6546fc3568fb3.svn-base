//
//  AddressItemCell.m
//  weidong
//
//  Created by zhccc on 2017/11/20.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "AddressItemCell.h"

@implementation AddressItemCell {
    DeliverAddressInfo *addressInfo;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_editBtn setRoundBorder];
    [_deleteBtn setRoundBorder];
    
    [_defaultLabel setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithAddressInfo:(DeliverAddressInfo *)addrInfo {
    addressInfo = addrInfo;
    
    _nameLabel.text = addrInfo.consignee;
    _phoneLabel.text = addrInfo.phone;
    NSString *areaString = [addrInfo.areaName stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *addressFull = [areaString stringByAppendingString:addrInfo.address];
    _addressLabel.text = addressFull;
    [_defaultLabel setHidden:!addressInfo.isDefault];
}

- (IBAction)editBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate editAddressInfo:addressInfo];
}

- (IBAction)deleteBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate deleteAddressInfo:addressInfo.id];
}

@end
