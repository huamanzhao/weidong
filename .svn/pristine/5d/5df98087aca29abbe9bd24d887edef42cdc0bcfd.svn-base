//
//  ScrollTableViewCell.m
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "SecondaryFuncCell.h"
#import "Constants.h"

@implementation ScrollTableViewCell {
    NSArray *itemList;
    NSArray *viewList;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat itemWidth = SCREEN_WIDTH / 2.5;
    CGFloat itemHeight = itemWidth * 5 / 8 - 2;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    
    _collection.delegate  = self;
    _collection.dataSource = self;
    _collection.showsVerticalScrollIndicator = NO;
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.collectionViewLayout = layout;
    [_collection registerNib:[UINib nibWithNibName:@"SecondaryFuncCell" bundle:nil] forCellWithReuseIdentifier:SENCONDARY_CELL_ID];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupByAdList: (NSArray *)list {
    itemList = list;
    
    [_collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SecondaryFuncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SENCONDARY_CELL_ID forIndexPath:indexPath];
    [cell setupWithAdInfo:[itemList objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    AdInfo *adinfo = [itemList objectAtIndex:row];
    
    if (self.delegate) {
        [self.delegate selectAdWithId:adinfo];
    }
}

@end
