//
//  ProductFilterView.h
//  weidong
//
//  Created by zhccc on 2017/10/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductFilterDelegate
- (void)filterCategoryIdSelected:(NSString *)categoryId;
- (void)dismissFilterView;
@end

@interface ProductFilterView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic, weak) id <ProductFilterDelegate> delegate;

- (void)setupWithCategoryList:(NSArray *)categoryList;
@end
