//
//  ArrivalNotifyCell.m
//  weidong
//
//  Created by zhccc on 2017/12/24.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ArrivalNotifyCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation ArrivalNotifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupWithNoficeInfo:(ArrivalNoticeInfo *)notice {
    _snLabel.text = [NSString stringWithFormat:@"编号：%@", notice.productSn];
    _nameLabel.text = notice.productName;
    _emailLabel.text = [NSString stringWithFormat:@"邮箱：%@", notice.email];
    
    if (STRING_NULL(notice.productImage)) {
        return;
    }
    
    NSURL *imageUrl = [NSURL URLWithString:notice.productImage];
    if (!imageUrl) {
        return;
    }
    
    [_productImage sd_setImageWithURL:imageUrl];
}

@end
