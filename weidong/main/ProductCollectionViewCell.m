//
//  ProductCollectionViewCell.m
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductImageInfo.h"

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWithProduct: (ProductInfo *)product {
    self.titleLabel.text = product.name;
//    self.descriptLabel.text = product.caption;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.price];
    
    NSString *imageUrlStr = @"";
    if ([product.productImages count] > 0) {
        ProductImageInfo *imageInfo = product.productImages.firstObject;
        imageUrlStr = imageInfo.medium;
    }
    if (STRING_NULL(imageUrlStr)) {
        imageUrlStr = product.image;
    }
    
    NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
    if (imageUrl) {
        [_productImage sd_setImageWithURL:imageUrl placeholderImage:UIImageWithName(@"default_2") options:SDWebImageProgressiveDownload];
    }
    
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
