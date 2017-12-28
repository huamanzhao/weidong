//
//  TitleCollectionCell.m
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "TitleCollectionCell.h"


@implementation TitleCollectionCell {
    UILabel *titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 4.0;
    self.layer.masksToBounds = YES;
    
    titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    _usrSelect = NO;
    
    return self;
}

- (void)layoutSubviews {
    titleLabel.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected {
    _usrSelect = selected;
    [self setupSelectLayout];
}

- (void)setupWithTitle: (NSString *)title {
    titleLabel.text = title;
}

- (void)setupSelectLayout {
    if (self.usrSelect) {
        self.backgroundColor = NEGATIVE_COLOR;
        titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor darkTextColor];
    }
}

@end
