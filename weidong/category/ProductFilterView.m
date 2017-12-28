//
//  ProductFilterView.m
//  weidong
//
//  Created by zhccc on 2017/10/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductFilterView.h"
#import "CategoryInfo.h"
#import "Util.h"

@interface WordCollectionCell : UICollectionViewCell
@property(nonatomic, assign)BOOL isSelect;

- (void)setupWithTitle: (NSString *)title;
- (void)setCellSelect;
@end

@implementation ProductFilterView {
    NSArray *categoryList;
    NSString *selectId;
    NSInteger selectIndex;
    
    NSString *cellIdentifier;
    UIControl *control;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ProductFilterView" owner:self options:nil] firstObject];
        self.frame = frame;
        
        selectIndex = -1;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    cellIdentifier = @"wordIdenfier";
    
    _finishBtn.backgroundColor = POSITIVE_COLOR;
    
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[WordCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    categoryList = [NSArray new];
}

- (IBAction)finishBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate filterCategoryIdSelected:selectId];
    }
    
    [self dismissView];
}

- (void)setupWithCategoryList:(NSArray *)categories {
    categoryList = categories;
    [_collection reloadData];
}

- (void)dismissView {
    if (_delegate) {
        [_delegate dismissFilterView];
    }
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return [categoryList count];
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [categoryList count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    CategoryInfo *category = [categoryList objectAtIndex:index];
    NSString *title = category.name;
    
    CGFloat cellHeight = 32;
    CGSize defaultSize = CGSizeMake(800, cellHeight);
    CGSize realSize  = [Util getTextBoundSize:title Font:[UIFont systemFontOfSize:14.0] Size:defaultSize];
    CGFloat cellWidth = realSize.width + 24;
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    CategoryInfo *category = [categoryList objectAtIndex:index];
    NSString *title = category.name;
    
    WordCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setupWithTitle:title];
    cell.isSelect = NO;
    
    if (selectIndex == index) {
        cell.isSelect = YES;
    }
    [cell setCellSelect];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    CategoryInfo *category = [categoryList objectAtIndex:row];
    selectId = category.id;
    
    selectIndex = row;
    [collectionView reloadData];
}

@end

@implementation WordCollectionCell {
    UILabel *titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.layer.cornerRadius = 4.0;
    
    titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:titleLabel];
    
    _isSelect = NO;
    
    return self;
}

- (void)layoutSubviews {
    titleLabel.frame = self.bounds;
}

- (void)setupWithTitle: (NSString *)title {
    titleLabel.text = title;
}

- (void)setCellSelect {
    [self setupCellLayout];
}

- (void)setupCellLayout {
    if (_isSelect) {
        titleLabel.textColor = NEGATIVE_COLOR;
    }
    else {
        titleLabel.textColor = [UIColor darkTextColor];
    }
}

@end
