//
//  PromotionTableViewCell.m
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "PromotionTableViewCell.h"

@implementation PromotionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)showPromotionList: (NSArray *)list {
    if (list == nil || [list count] == 0) {
        return;
    }
    
    _loopView.delegate = self.delegate;
    [_loopView showViewWithPromotions:list];
}

@end
