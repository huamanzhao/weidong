//
//  SecondaryFuncCell.m
//  GZDefence
//
//  Created by zhccc on 2017/8/24.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "SecondaryFuncCell.h"
#import "AdInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SecondaryFuncCell {
    AdInfo *ad;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.titleLabel setHidden:YES];
    [self.subTitleLabel setHidden:YES];
    self.itemImage.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupWithAdInfo: (AdInfo *)adinfo {
    ad = adinfo;
    NSURL *imageUrl = [NSURL URLWithString:adinfo.path];
    [self.itemImage sd_setImageWithURL:imageUrl placeholderImage:UIImageWithName(@"default_3") options:SDWebImageProgressiveDownload];
}

@end
