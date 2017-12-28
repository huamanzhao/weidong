//
//  MemberTitleView.h
//  weidong
//
//  Created by zhccc on 2017/12/26.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelfInfo.h"

@interface MemberTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *verifyLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;

- (void)setupWithUserName:(NSString *)user Ranking:(NSString *)rank;
@end
