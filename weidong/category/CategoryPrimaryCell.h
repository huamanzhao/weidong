//
//  CategoryPrimaryCell.h
//  weidong
//
//  Created by zhccc on 2017/10/23.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryInfo.h"

#define CATEGORYPRIMARY_CELLID @"categoryPrimaryID"

@protocol CetegoryPrimaryDelegate <NSObject>
- (void)selectPrimaryCategory:(CategoryInfo *)category;
- (void)selectChildCategory:(CategoryInfo *)category;
@end

@interface CategoryPrimaryCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *titleBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *colletion;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horzLeadingCS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horzTrailingCS;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeightCS;

@property (nonatomic, weak) id<CetegoryPrimaryDelegate> delegate;

- (void)setupWithCategory:(CategoryInfo *)category;

@end
