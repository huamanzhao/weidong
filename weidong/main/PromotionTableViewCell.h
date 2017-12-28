//
//  PromotionTableViewCell.h
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoopView.h"

#define RECOMMEND_CELL_ID @"PromotionCellIdentifier"

@interface PromotionTableViewCell : UITableViewCell

@property(nonatomic, weak) id<LoopDelegate> delegate;
@property(weak, nonatomic) IBOutlet LoopView *loopView;

- (void)showPromotionList: (NSArray *)list;

@end
