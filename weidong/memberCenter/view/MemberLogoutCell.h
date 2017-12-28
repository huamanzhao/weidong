//
//  MemberLogoutCell.h
//  weidong
//
//  Created by zhccc on 2017/11/6.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LOGOUT_CELLID @"logoutCellId"

@protocol MemberLogoutDelegate <NSObject>
- (void)logoutAction;
@end

@interface MemberLogoutCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@property(nonatomic, weak) id<MemberLogoutDelegate> delegate;
@end
