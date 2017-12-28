//
//  ConsulateProductCell.m
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ConsulateProductCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ConsulateProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithConsulation:(ConsultationInfo *)info {
    [_scoreLabel setHidden:YES];
    _scoreWIdthCS.constant = 0;
    
    _dateLabel.text = info.createdDate;
    _nameLabel.text = info.productName;
    
    if (STRING_NULL(info.productImage)) {
        return;
    }
    NSURL *imageURL = [NSURL URLWithString:info.productImage];
    if (!imageURL) {
        return;
    }
    
    [_productImage sd_setImageWithURL:imageURL];
}

- (void)setupWithComment:(CommentInfo *)info {
    _dateLabel.text = info.createDate;
    _nameLabel.text = info.productName;
    _scoreLabel.text = [NSString stringWithFormat:@"评分:%.0f", info.score];
    
    if (STRING_NULL(info.productImage)) {
        return;
    }
    NSURL *imageURL = [NSURL URLWithString:info.productImage];
    if (!imageURL) {
        return;
    }
    
    [_productImage sd_setImageWithURL:imageURL];
}

@end
