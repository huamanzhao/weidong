//
//  CartItemCell.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CartItemCell.h"
#import <SDwebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@implementation CartItemCell {
    CartItemInfo *cart;
    NSInteger quantity;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    quantity = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithCartInfo:(CartItemInfo *)cartInfo  InEdit:(BOOL)inEdit{
    cart = cartInfo;
    quantity = cartInfo.quantity;
    _nameLabel.text = cartInfo.productName;
    _specificationLabel.text = cartInfo.skuName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [cartInfo.price floatValue]];
    [self updateQuantityText];
    
    if (STRING_NULL(cartInfo.skuThumbnail)) {
        return;
    }
    NSURL *url = [NSURL URLWithString:cartInfo.skuThumbnail];
    [_productImage sd_setImageWithURL:url placeholderImage:UIImageWithName(@"default_1")];
    
    if (inEdit) {
        [_deleteBtn setHidden:NO];
        _deleteBtnWidthCS.constant = 36;
    }
    else {
        [_deleteBtn setHidden:YES];
        _deleteBtnWidthCS.constant = 0;
    }
    
}

- (void)updateQuantityText {
    _quantityTF.text = [NSString stringWithFormat:@"%ld", quantity];
}

- (IBAction)minusBtnPressed:(id)sender {
    if (quantity <= 1) {
        [SVProgressHUD showInfoWithStatus:@"数量必须大于零"];
        return;
    }
    
    quantity = quantity - 1;
    [self updateQuantityText];
    
    if (self.delegate) {
        cart.quantity = quantity;
        [_delegate cartModified:cart];
    }
}

- (IBAction)addBtnPressed:(id)sender {
    quantity = quantity + 1;
    [self updateQuantityText];
    
    if (self.delegate) {
        cart.quantity = quantity;
        [_delegate cartModified:cart];
    }
}

- (IBAction)removeBtnPressed:(id)sender {
    if (self.delegate) {
        cart.quantity = quantity;
        [_delegate cartRemoved:cart];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger quantity = [textField.text integerValue];
    if (quantity <= 0) {
        [SVProgressHUD showInfoWithStatus:@"数量必须大于零"];
        return;
    }
    
    if (self.delegate) {
        cart.quantity = quantity;
        [_delegate cartModified:cart];
    }
}

@end
