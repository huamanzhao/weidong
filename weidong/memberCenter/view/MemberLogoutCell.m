//
//  MemberLogoutCell.m
//  weidong
//
//  Created by zhccc on 2017/11/6.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberLogoutCell.h"

@implementation MemberLogoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _logoutBtn.backgroundColor = COLOR_0;
    [_logoutBtn setRoundCornerWithRadius:6.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)logoutBtnPressed:(id)sender {
    if (self.delegate) {
        [self.delegate logoutAction];
    }
}

@end
