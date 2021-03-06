//
//  HeaderSearchView.m
//  weidong
//
//  Created by zhccc on 2017/10/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "HeaderSearchView.h"
#import "SVProgressHUD.h"
#import "Util.h"
#import "Constants.h"

@implementation HeaderSearchView {
    NSArray *titleList;
    NSString *cellIdentifier;
    
    CGFloat headerHeight;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderSearchView" owner:self options:nil] lastObject];
//        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    headerHeight = 144;
    [self initViewLayout];
    
    _searchTF.delegate = self;
    _collection.delegate = self;
    _collection.dataSource = self;
    
    cellIdentifier = @"titleCellIdentifier";
    [_collection registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [self addShadowLayer];
}

- (void)initViewLayout {
    _searchBgView.layer.cornerRadius = 8.0;
    _searchBgView.layer.masksToBounds = YES;
    _searchBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect thisFrame = self.frame;
    thisFrame.size.height = headerHeight;
    thisFrame.size.width = SCREEN_WIDTH;
    self.frame = thisFrame;
}

- (void)showWithTitles: (NSArray *)list {
    titleList = list;
    
    if ([list count] == 0) {
        titleList = @[@"空调", @"冰箱", @"iphone 8", @"微波炉", @"hdmi 雷电", @"小米耳机"];
    }
    [_collection reloadData];
    
    UIViewController *topVC = [Util getTopViewController];
//    self.frame = CGRectMake(0, 20, SCREEN_WIDTH, headerHeight);
    [topVC.view addSubview:self];
    
    self.transform = CGAffineTransformTranslate(self.transform, 0, -(headerHeight+20));
        [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss {
    self.transform = CGAffineTransformTranslate(self.transform, 0, -(headerHeight+20));
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    [self removeFromSuperview];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [titleList count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    NSString *title = [titleList objectAtIndex:index];
    
    CGFloat cellHeight = 26;
    CGSize defaultSize = CGSizeMake(800, cellHeight);
    CGSize realSize  = [Util getTextBoundSize:title Font:[UIFont systemFontOfSize:14.0] Size:defaultSize];
    CGFloat cellWidth = realSize.width + 16;
    
    return CGSizeMake(cellWidth, cellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    NSString *title = [titleList objectAtIndex:index];
    
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setupWithTitle:title];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    NSString *title = [titleList objectAtIndex:row];
    self.searchTF.text = title;
    if (self.delegate) {
        [self.delegate productSearch:title];
    }
}

- (IBAction)searchBtnPressed:(id)sender {
    if (STRING_NULL(_searchTF.text)) {
        return;
    }
    
    [_searchTF resignFirstResponder];
    
    NSString *title = _searchTF.text;
    if (self.delegate) {
        [self.delegate productSearch:title];
    }
}

- (IBAction)RetractBtnPressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 0, -(headerHeight+20));
    } completion:^(BOOL finished) {
        if (_delegate) {
            [_delegate searchHeaderDismissed];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (STRING_NULL(_searchTF.text)) {
        return YES;
    }
    NSString *title = _searchTF.text;
    if (self.delegate) {
        [self.delegate productSearch:title];
    }
    
    return YES;
}

@end




