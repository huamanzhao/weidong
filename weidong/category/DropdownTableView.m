//
//  DropdownTableView.m
//  weidong
//
//  Created by zhccc on 2017/10/22.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "DropdownTableView.h"
#import "Constants.h"

@implementation DropdownTableView {
    NSArray *titleArray;
    NSArray *imageArray;
    CGFloat rowHeight;
    
    NSInteger type;     //0:只有文字  1：图片+文字
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    titleArray = [NSArray new];
    rowHeight = 36;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = rowHeight;
    
    _tableView.layer.cornerRadius = 3.0;
    _tableView.layer.shadowRadius = 4.0;
    _tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    _tableView.layer.shadowOpacity = 0.5;
    _tableView.layer.shadowOffset = CGSizeMake(2, 4);
}

- (void)layoutSubviews {
    _tableWidth.constant = SCREEN_WIDTH * 0.4;
    _tableHeight.constant = [titleArray count] * rowHeight;
    [self setNeedsUpdateConstraints];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    if (type == 1) {
        cell.imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!self.delegate) {
        return;
    }
    if (type == 0) {
        [self.delegate selectSortItemAtIndex:indexPath.row];
    }
    else {
        [self.delegate selectFuncItemAtIndex:indexPath.row];
    }
}

- (void)setupWithTitles:(NSArray *)list {
    type = 0;
    titleArray = list;
    
    [self.tableView reloadData];
    [self setNeedsLayout];
}
- (void)setupWithTitles:(NSArray *)titleList Images: (NSArray *)imageList {
    type = 1;
    titleArray = titleList;
    imageArray = imageList;
    
    [self.tableView reloadData];
    [self setNeedsLayout];
}

@end
