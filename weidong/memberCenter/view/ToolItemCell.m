//
//  ToolItemCell.m
//  weidong
//
//  Created by zhccc on 2018/6/7.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "ToolItemCell.h"

@implementation ToolItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupCellWithTitle: (NSString *)title Image:(NSString *)name {
    self.imageV.image = UIImageWithName(name);
    self.titleLabel.text = title;
}

@end
