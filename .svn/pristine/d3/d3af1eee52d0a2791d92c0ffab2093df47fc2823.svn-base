//
//  MemberTableSectionView.m
//  weidong
//
//  Created by zhccc on 2017/11/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberTableSectionView.h"

@implementation MemberTableSectionView {
    NSString *sectionTitle;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MemberTableSectionView" owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)setupWithTitle:(NSString *)title Image:(NSString *)imageName Subtitle:(NSString *)subTitle TintColor:(UIColor *)color {
    sectionTitle = title;
    self.titleLabel.text = title;
    if (color) {
        self.titleLabel.textColor = color;
    }
    self.imageView.image = UIImageWithName(imageName);
    if (!STRING_NULL(subTitle)) {
        NSString *btnTitle = [subTitle stringByAppendingString:@">"];
        [self.subtitleBtn setTitle:btnTitle forState:UIControlStateNormal];
    }
}

- (IBAction)subtitleBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    if ([sectionTitle isEqualToString:MEMBER_MY_ORDER]) {
        [_delegate showMoreOrders];
    }
    else if ([sectionTitle isEqualToString:MEMBER_SETTINGS]) {
        [_delegate manageDeliveryAddress];
    }
    else if ([sectionTitle isEqualToString:MEMBER_PERSONAL]) {
        [_delegate managePersonalInfo];
    }
    else if ([sectionTitle isEqualToString:MEMBER_CHANGEPSW]) {
        [_delegate changePassword];
    }
}

@end
