//
//  ToolItemCell.h
//  weidong
//
//  Created by zhccc on 2018/6/7.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ToolItemCellID @"ToolItemCellID"

@interface ToolItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setupCellWithTitle: (NSString *)title Image:(NSString *)name;

@end
