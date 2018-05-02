//
//  ProductItemCell.m
//  weidong
//
//  Created by zhccc on 2017/10/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductItemCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductImageInfo.h"

@implementation ProductItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setupWithProduct: (ProductInfo *)product {
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
        [_image sd_setImageWithURL:imageUrl placeholderImage:UIImageWithName(@"default_2") options:SDWebImageProgressiveDownload];
    }
    
}

@end
