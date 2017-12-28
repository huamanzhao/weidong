//
//  ProductItemCell.m
//  weidong
//
//  Created by zhccc on 2017/10/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductItemCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ProductItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupWithProduct: (ProductInfo *)product {
    [_image sd_setImageWithURL:[NSURL URLWithString:product.image] placeholderImage:UIImageWithName(@"default_4")];
    _titleLabel.text = product.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.price];
    
    NSString *imageName = @"";
    switch (product.productType) {
        case ProductType_Trade:
            imageName = @"product_damao";
            break;
            
        case ProductType_Bonded:
            imageName = @"product_baoshui";
            break;
            
        case ProductType_Deliver:
            imageName = @"product_zhiyou";
            break;
            
        default:
            break;
    }
    if (!STRING_NULL(imageName)) {
        _typeImage.image = UIImageWithName(imageName);
    }
    
}

@end
