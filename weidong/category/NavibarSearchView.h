//
//  NavibarSearchView.h
//  weidong
//
//  Created by zhccc on 2017/10/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enum.h"

@protocol NavibarSearchViewDelegate <NSObject>
- (void)popViewController;
- (void)searchProductWithKey:(NSString *)keyword;
- (void)setSearchSortType:(ProductOrderType)type;
- (void)showSortDropdownView;
- (void)showFuncDropdownView;
- (void)showFilterView;
@end


@interface NavibarSearchView : UIView <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *searchBgView;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *tabButton;
@property (weak, nonatomic) IBOutlet UIButton *complexBtn;
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
@property (weak, nonatomic) IBOutlet UIButton *scoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *filterBtn;
@property (weak, nonatomic) IBOutlet UIView *funcView;

@property (nonatomic, weak) id <NavibarSearchViewDelegate> delegate;

- (void)setSearchTitle:(NSString *)title;
- (void)updateComplexType:(NSString *)type;

@end
