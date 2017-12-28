//
//  ScrollTableViewCell.h
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdInfo.h"

#define SCROLL_CELL_ID @"scrollCellIdentifier"

@protocol ScrollCellDelegate <NSObject>

- (void)selectAdWithId: (AdInfo *)adInfo;

@end

@interface ScrollTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, weak) id <ScrollCellDelegate> delegate;

- (void)setupByAdList: (NSArray *)list;

@end
