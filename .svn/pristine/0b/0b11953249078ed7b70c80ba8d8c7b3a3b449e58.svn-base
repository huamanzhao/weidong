//
//  HeaderSearchView.h
//  weidong
//
//  Created by zhccc on 2017/10/11.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleCollectionCell.h"

@protocol HeaderSearchViewDelegate <NSObject>
- (void)productSearch:(NSString *)keyStr;
- (void)searchHeaderDismissed;
@end


@interface HeaderSearchView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property(weak, nonatomic) id<HeaderSearchViewDelegate> delegate;

- (void)showWithTitles: (NSArray *)list;
- (void)dismiss;

@end

