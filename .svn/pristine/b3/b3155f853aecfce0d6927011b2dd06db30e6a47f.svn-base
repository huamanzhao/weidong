//
//  ConsulateProductCell.h
//  weidong
//
//  Created by zhccc on 2017/12/21.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultationInfo.h"
#import "CommentInfo.h"

#define CONSULATE_CELLID @"ConsulateCellIdentifier"

@interface ConsulateProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreWIdthCS;

- (void)setupWithConsulation:(ConsultationInfo *)info;
- (void)setupWithComment:(CommentInfo *)info;
@end
