//
//  MemberOrderCell.h
//  weidong
//
//  Created by zhccc on 2017/11/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ORDER_CELLID @"orderIdentifier"

@protocol MemberOrderDelegate <NSObject>
- (void)showOrderListWithType:(OrderListType)type;
@end

@interface MemberOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *waitReceiveBtn;
@property (nonatomic, weak) id<MemberOrderDelegate> delegate;

- (void)setupWithOrderCountsUnpay:(NSInteger)num1 UnSend:(NSInteger)num2 UnReceive:(NSInteger)num3;
@end
