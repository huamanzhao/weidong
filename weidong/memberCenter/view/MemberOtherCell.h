//
//  MemberOtherCell.h
//  weidong
//
//  Created by zhccc on 2018/5/29.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MemberOtherCellID @"otherCellIdentifier"

@protocol MemberOtherCellDelegate <NSObject>
- (void)otherFunctionSelected:(NSInteger)index;
@end

@interface MemberOtherCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id<MemberOtherCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end
