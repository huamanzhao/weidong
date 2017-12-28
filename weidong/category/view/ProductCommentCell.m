//
//  ProductCommentCell.m
//  weidong
//
//  Created by zhccc on 2017/11/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductCommentCell.h"

@implementation ProductCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithComment:(CommentInfo *)comment {
    NSString *name = @"";
    if (!comment.isShow) {
        name = @"匿名用户";
    }
    else {
        if (!STRING_NULL(comment.memberName)) {
            name = comment.memberName;
        }
        else {
            name = @"匿名用户";
        }
    }
    _nameLabel.text = name;
    
    _scoreLabel.text = [NSString stringWithFormat:@"%.1f", comment.score];
    _contentLabel.text = comment.content;
}

@end
