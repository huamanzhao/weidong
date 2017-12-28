//
//  DropdownTableView.h
//  weidong
//
//  Created by zhccc on 2017/10/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SortDropDownDelegate <NSObject>

- (void)selectSortItemAtIndex:(NSInteger)index;
- (void)selectFuncItemAtIndex:(NSInteger)index;

@end


@interface DropdownTableView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableWidth;

@property(nonatomic, weak) id<SortDropDownDelegate> delegate;

- (void)setupWithTitles:(NSArray *)list;
- (void)setupWithTitles:(NSArray *)titleList Images: (NSArray *)imageList;

@end
