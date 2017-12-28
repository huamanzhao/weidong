//
//  MemberFunctionView.m
//  weidong
//
//  Created by zhccc on 2017/11/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "MemberFunctionView.h"

@implementation MemberFunctionView {
    UIView *nibView;
}

- (instancetype)initFuncViewFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        nibView = [[NSBundle mainBundle] loadNibNamed:@"MemberFunctionView" owner:self options:nil].firstObject;
        nibView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:nibView];
        
        [_favoriteBtn setTitle:@"商品收藏" forState:UIControlStateNormal];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [_favoriteBtn adjustItemsUpDown];
    [_deliveryBtn adjustItemsUpDown];
    [_commentBtn adjustItemsUpDown];
    [_ConsulteBtn adjustItemsUpDown];
}

- (void)setupBadgeWithFavorite:(NSInteger)num1 Delivery:(NSInteger)num2 Comment:(NSInteger)num3 Consult:(NSInteger)num4 {
    [_favoriteBtn setBadge:num1];
    [_deliveryBtn setBadge:num2];
    [_commentBtn setBadge:num3];
    [_ConsulteBtn setBadge:num4];
}

- (IBAction)favariteBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate showFavoriteProducts];
}

- (IBAction)deliveryBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate showArrivalNotications];
}

- (IBAction)commentBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate showProductComments];
}

- (IBAction)consultBtnPressed:(id)sender {
    if (!_delegate) {
        return;
    }
    
    [_delegate showProductConsults];
}
@end
