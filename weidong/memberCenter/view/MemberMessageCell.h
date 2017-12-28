//
//  MemberMessageCell.h
//  weidong
//
//  Created by zhccc on 2017/11/6.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MESSAGE_CELLID @"messageIdentifier"

@interface MemberMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mineBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *draftBtn;
@end
