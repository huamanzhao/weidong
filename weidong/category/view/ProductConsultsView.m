//
//  ProductConsultsView.m
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductConsultsView.h"
#import "ConsultationInfo.h"
#import "ProductConsulateCell.h"

@implementation ProductConsultsView {
    NSArray *consulationList;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ProductConsultsView" owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    consulationList = [NSArray new];
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100;
    [_table registerNib:[UINib nibWithNibName:@"ProductConsulateCell" bundle:nil] forCellReuseIdentifier:PRODUCTCONSULATION_ID];
    [self bringSubviewToFront:_emptyView];
    
    //下拉切换页面
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.delegate) {
            [self.delegate showProductComments];
        }
        [_table.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉切换页面" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换页面" forState:MJRefreshStateRefreshing];
    _table.mj_header = header;
}

- (void)reloadTableWithConsults:(NSArray *)consultList {
    if (!consultList || [consultList count] == 0) {
        [self bringSubviewToFront:_emptyView];
        return;
    }
    [self sendSubviewToBack:_emptyView];
    
    consulationList = consultList;
    [_table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [consulationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductConsulateCell *cell = [tableView dequeueReusableCellWithIdentifier:PRODUCTCONSULATION_ID forIndexPath:indexPath];
    ConsultationInfo *cosulation = [consulationList objectAtIndex:indexPath.row];
    [cell setupWithConsulation:cosulation];
    return cell;
}

@end
