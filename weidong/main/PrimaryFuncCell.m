//
//  PrimaryFuncCell.m
//  GZDefence
//
//  Created by zhccc on 2017/8/24.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "PrimaryFuncCell.h"
#import "Util.h"

@implementation PrimaryFuncCell
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupPrimaryCell: (NSInteger)row {
    NSString *imageName;
    NSString *title;
    
    switch (row) {
        case 0:
            imageName = @"collect_0";
            title = @"商品分类";
            break;
            
        case 1:
            imageName = @"collect_1";
            title = @"积分乐园";
            break;
            
        case 2:
            imageName = @"collect_2";
            title = @"充值中心";
            break;
            
        case 3:
            imageName = @"collect_3";
            title = @"会员中心";
            break;
            
        case 4:     //ZC_DEBUG
            imageName = @"collect_7";
            title = @"直邮到家";
            break;
            
        case 5:
            imageName = @"collect_5";
            title = @"全城优食";
            break;
            
        case 6:
            imageName = @"collect_6";
            title = @"微动精选";
            break;
            
        case 7:     //ZC_DEBUG
            imageName = @"collect_4";
            title = @"母婴世界";
            break;
            
        default:
            break;
    }
    
    self.centerImage.image = UIImageWithName(imageName);
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor darkTextColor];
}

- (void)setupCellWithTitle: (NSString *)title Image:(NSString *)name {
//    self.centerImage.image = UIImageWithName(name);
//    self.titleLabel.text = title;
//    self.titleLabel.textColor = [UIColor darkTextColor];
}

@end
