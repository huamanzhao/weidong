//
//  FavoriteProductCell.m
//  weidong
//
//  Created by zhccc on 2017/11/8.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "FavoriteProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation FavoriteProductCell {
    FavoriteProductInfo *favoriteInfo;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)removeBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate removeProductWithId:favoriteInfo.id];
    }
}

- (void)setupWithFavoriteProduct:(FavoriteProductInfo *)favorite {
    if (!favorite) {
        return;
    }
    
    favoriteInfo = favorite;
    
    _nameLabel.text = favorite.productName;
    _descLabel.text = favorite.productCaption;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", favorite.productPrice];
    
    if (STRING_NULL(favorite.productImage)) {
        return;
    }
    NSURL *url = [NSURL URLWithString:favorite.productImage];
    if (!url) {
        return;
    }
    
    [_productImage sd_setImageWithURL:url];
}

@end
