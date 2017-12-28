//
//  CategoryTableViewCell.m
//  weidong
//
//  Created by zhccc on 2017/10/5.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "ProductCollectionViewCell.h"
#import "Constants.h"
#import "CategoryInfo.h"
#import "ProductInfo.h"

@implementation CategoryTableViewCell {
    CategoryInfo *_category;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PRODUCT_CELL_ID];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 2) / 3;
    CGFloat itemHeight = itemWidth * 3 / 2;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 1.0;
    layout.minimumLineSpacing = 1.0;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    _collection.collectionViewLayout = layout;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupByCategory: (CategoryInfo *)category {
    _category = category;
    
    [_collection reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_category.productList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PRODUCT_CELL_ID forIndexPath:indexPath];
    NSInteger index = indexPath.row;
    ProductInfo *product = [_category.productList objectAtIndex:index];
    [cell setupWithProduct:product];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    ProductInfo *product = [_category.productList objectAtIndex:index];
    
    if (self.delegate) {
        [self.delegate selectProductWithID:product.id];
    }
}

@end
