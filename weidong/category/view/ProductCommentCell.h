//
//  ProductCommentCell.h
//  weidong
//
//  Created by zhccc on 2017/11/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentInfo.h"

#define PRODUCT_COMMENT_CELLID @"productCommentId"

@interface ProductCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setupWithComment:(CommentInfo *)comment;

@end
