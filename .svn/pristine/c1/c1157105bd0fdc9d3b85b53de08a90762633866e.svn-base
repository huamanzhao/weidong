//
//  ProductConsulateCell.m
//  weidong
//
//  Created by zhccc on 2017/12/1.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductConsulateCell.h"

@implementation ProductConsulateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _QIcon.layer.cornerRadius = 3.0;
    _QIcon.backgroundColor = POSITIVE_COLOR;
    _AIcon.layer.cornerRadius = 3.0;
    _AIcon.backgroundColor = NEGATIVE_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithConsulation:(ConsultationInfo *)info {
    _nameLabel.text = info.memberName;
    _timeLabel.text = info.createdDate;
    _questionLabel.text = info.content;
    
    if (!info.replyAppConsultations || ![info.replyAppConsultations count]) {
        [_AIcon setHidden:YES];
    }
    else {
        [_AIcon setHidden:NO];
        ConsultationInfo *reply = [info.replyAppConsultations firstObject];
        _answerLabel.text = reply.content;
    }
}

@end
