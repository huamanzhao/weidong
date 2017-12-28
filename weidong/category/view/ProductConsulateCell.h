//
//  ProductConsulateCell.h
//  weidong
//
//  Created by zhccc on 2017/12/1.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultationInfo.h"

#define PRODUCTCONSULATION_ID @"consulation_id"

@interface ProductConsulateCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *QIcon;
@property (weak, nonatomic) IBOutlet UILabel *AIcon;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

- (void)setupWithConsulation:(ConsultationInfo *)info;
@end
