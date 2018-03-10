//
//  CoinDetailViewController.m
//  weidong
//
//  Created by zhccc on 2018/2/4.
//  Copyright © 2018年 zhccc. All rights reserved.
//

#import "CoinDetailViewController.h"

@interface CoinDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@end

@implementation CoinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBackButton];
    [self initNaviTopEdge];
    self.title = @"详情";
    
    [self setupWithCoinInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWithCoinInfo {
    _dateLabel.text = [[_coinLog.createDate toDate:@"yyyyMMddHHmmss"] toString:@"yyyy-MM-dd HH:mm"];
    _orderLabel.text = _coinLog.orderSn;
    
    NSString *type = @"";
    switch (_coinLog.type) {
        case 0: {
            type = @"预存款充值";
            break;
        }
        case 1: {
            type = @"预存款调整";
            break;
        }
        case 2: {
            type = @"订单支付";
            break;
        }
        case 3: {
            type = @"订单退款";
            break;
        }
            
        default:
            break;
    }
    _typeLabel.text = type;
    
    NSString *changeTitle = @"金额";
    NSString *changeValue = @"0.0";
    if (_coinLog.credit > 0) {
        changeTitle = @"收入金额";
        changeValue = [NSString stringWithFormat:@"%.2f", _coinLog.credit];
    }
    if (_coinLog.debit > 0) {
        changeTitle = @"支出金额";
        changeValue = [NSString stringWithFormat:@"%.2f", _coinLog.debit];
    }
    _changeTitleLabel.text = changeTitle;
    _changeValueLabel.text = changeValue;
    
    _balanceLabel.text = [NSString stringWithFormat:@"%.2f", _coinLog.balance];
}

@end
