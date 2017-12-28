//
//  MemberTableSectionView.h
//  weidong
//
//  Created by zhccc on 2017/11/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MemberTableSectionDelegate <NSObject>
- (void)showMoreOrders;
- (void)manageDeliveryAddress;
- (void)managePersonalInfo;
- (void)changePassword;
@end


@interface MemberTableSectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *subtitleBtn;

@property (nonatomic, weak) id<MemberTableSectionDelegate> delegate;

- (void)setupWithTitle:(NSString *)title Image:(NSString *)imageName Subtitle:(NSString *)subTitle TintColor:(UIColor *)color;
@end
