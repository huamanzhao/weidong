//
//  MemberOtherCell.m
//  weidong
//
//  Created by zhccc on 2018/5/29.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "MemberOtherCell.h"
#import "PrimaryFuncCell.h"

@implementation MemberOtherCell {
    NSArray *titleList;
    NSArray *imageList;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerNib:[UINib nibWithNibName:@"PrimaryFuncCell" bundle:nil] forCellWithReuseIdentifier:PrimaryCellIdentifier];
    
    titleList = @[@"我的积分", @"微动币", @"微动币充值", @"优惠券", @"微豆充值", @"我的微豆"];
    imageList = @[@"tool_credit", @"tool_charge", @"tool_coin", @"tool_coupon", @"icon_weidou_charge", @"icon_weidou_log"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PrimaryFuncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PrimaryCellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    
    [cell setupCellWithTitle:[titleList objectAtIndex:row] Image:[imageList objectAtIndex:row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat length = (SCREEN_WIDTH - 10 * 3) / 4 ;
    
    return CGSizeMake(length, length);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (!_delegate) {
        return;
    }
    
    NSInteger row = indexPath.row;
    [_delegate otherFunctionSelected:row];
}

@end
