//
//  CollectionTableViewCell.m
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "PrimaryFuncCell.h"
#import "Constants.h"
#import "CategoryInfo.h"

@implementation CollectionTableViewCell {
    NSArray *funcCategoryList;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerNib:[UINib nibWithNibName:@"PrimaryFuncCell" bundle:nil] forCellWithReuseIdentifier:PrimaryCellIdentifier];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PrimaryFuncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PrimaryCellIdentifier forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    
    [cell setupPrimaryCell:indexPath.row];
    if (row > 3) {
        NSInteger index = indexPath.row - 4;
        CategoryInfo *category = [funcCategoryList objectAtIndex:index];
        NSString *title = category.name;
//        NSString *imgStr = category.
        [cell setupCellWithTitle:title Image:nil];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat length = SCREEN_WIDTH / 4;
    
    return CGSizeMake(length, length);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (!_delegate) {
        return;
    }
    
    NSInteger row = indexPath.row;
    
    NSString *categoryId = @"";
    
    //ZC_DEBUG  直邮到家、母婴世界两个按钮换位置后，这里的点击逻辑要修改
    //现在第二行第一个是直邮、最后一个是母婴世界
    
    if (row > 4) {
        NSInteger index = indexPath.row - 4;
        CategoryInfo *category = [funcCategoryList objectAtIndex:index];
        categoryId = category.id;
    }
    
    switch (row) {
        case 0:
            [_delegate openCategoryVC];
            break;
        case 1:
            [_delegate openCreditPark];
            break;
        case 2:
            [_delegate openChargeCenter];
            break;
        case 3:
            [_delegate openMemberCenter];
            break;
        case 4:
            [_delegate openZhiyouProductList];  //目前这个是直邮到家
            break;
        case 5:
            [_delegate openCategoryWithID:categoryId];
            break;
        case 6:
            [_delegate openHotSellingProducts];
            break;
        case 7:
            [_delegate openCategoryWithID:categoryId];
            break;
    }
}

- (void)setupWithCategoryList:(NSArray *)list {
    if (list && [list count]) {
        funcCategoryList = list;
        [_collection reloadData];
    }
}

@end
