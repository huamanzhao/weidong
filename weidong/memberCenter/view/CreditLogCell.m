//
//  CreditLogCell.m
//  weidong
//
//  Created by zhccc on 2017/11/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "CreditLogCell.h"

@interface CreditLogCell ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation CreditLogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCreditTitleStyle {
    _typeLabel.text = @"类型";
    _typeLabel.textColor = [UIColor darkGrayColor];
    
    _changeLabel.text = @"+/-";
    _changeLabel.textColor = [UIColor darkGrayColor];
    
    _balanceLabel.text = @"当前积分";
    _balanceLabel.textColor = [UIColor darkGrayColor];
}

- (void)setupWithCredit:(CreditLogInfo *)credit Index:(NSInteger)index {
    NSString *type = @"";
    UIColor *textColor;
    switch (credit.type) {
        case 0: {
            type = @"积分赠送";
            break;
        }
        case 1: {
            type = @"积分兑换";
            break;
        }
        case 2: {
            type = @"兑换撤销";
            break;
        }
        case 3: {
            type = @"积分调整";
            break;
        }
            
        default:
            break;
    }
    _typeLabel.text = type;
    
    if (credit.credit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"+%ld", (long)credit.credit];
        _changeLabel.textColor = POSITIVE_COLOR;
    }
    else if (credit.debit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"-%ld", (long)credit.debit];
        _changeLabel.textColor = NEGATIVE_COLOR;
    }
    
    _balanceLabel.text = [NSString stringWithFormat:@"%ld", (long)credit.balance];
    
    if (index % 2) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor colorWithHex:0xFFF5EE];
    }
}

- (void)setupCoinTitleStyle {
    _typeLabel.text = @"变动方式";
    _typeLabel.textColor = [UIColor darkGrayColor];
    
    _changeLabel.text = @"+/-";
    _changeLabel.textColor = [UIColor darkGrayColor];
    
    _balanceLabel.text = @"当前余额";
    _balanceLabel.textColor = [UIColor darkGrayColor];
}

- (void)setupWithCoin:(CoinLogInfo *)log Index:(NSInteger)index {
    NSString *type = @"";
    UIColor *textColor;
    switch (log.type) {
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
    
    if (log.credit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"+%.2f", log.credit];
        _changeLabel.textColor = POSITIVE_COLOR;
    }
    else if (log.debit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"-%.2f", log.debit];
        _changeLabel.textColor = [UIColor colorWithHex:0xEE0000];
    }
    
    _balanceLabel.text = [NSString stringWithFormat:@"%.2f", log.balance];
    
    if (index % 2) {
        self.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor colorWithHex:0xFFF8DC];
    }
}

- (void)setupBeanTitleStyle {
    _typeLabel.text = @"类型";
    _typeLabel.textColor = [UIColor darkGrayColor];
    
    _changeLabel.text = @"+/-";
    _changeLabel.textColor = [UIColor darkGrayColor];
    
    _balanceLabel.text = @"当前余额";
    _balanceLabel.textColor = [UIColor darkGrayColor];
}

- (void)setupWithBean:(CreditLogInfo *)bean Index:(NSInteger)index {
    NSString *type = @"";
    switch (bean.type) {
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
    
    if (bean.credit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"+%.2ld", (long)bean.credit];
        _changeLabel.textColor = POSITIVE_COLOR;
    }
    else if (bean.debit > 0) {
        _changeLabel.text = [NSString stringWithFormat:@"-%.2ld", (long)bean.debit];
        _changeLabel.textColor = [UIColor colorWithHex:0xEE0000];
    }
    
    _balanceLabel.text = [NSString stringWithFormat:@"%.2ld", (long)bean.balance];
    
    if (index % 2) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    else {
        self.backgroundColor = [UIColor colorWithHex:0xFFF8DC];
    }
}

@end
