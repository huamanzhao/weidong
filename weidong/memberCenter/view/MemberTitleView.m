//
//  MemberTitleView.m
//  weidong
//
//  Created by zhccc on 2017/12/26.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberTitleView.h"

@implementation MemberTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MemberTitleView" owner:self options:nil].firstObject;
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 39);
}

- (void)setupWithUserName:(NSString *)user Ranking:(NSString *)rank {
    _nameLabel.text = user;
    _memberLabel.text = rank;
    
    if ([Util userIsVerified]) {
        [_verifyLabel setText:@"已实名认证"];
    }
    else {
        [_verifyLabel setText:@"未实名认证"];
    }
}

@end
