//
//  VerifyCodeView.m
//  weidong
//
//  Created by zhccc on 2017/10/7.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "VerifyCodeView.h"

#define ARC4RAND_MAX 0x100000000

@implementation VerifyCodeView {
    UIView *bgView;
    UIButton *refreshBtn;
    
    NSArray *codeArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    refreshBtn.backgroundColor = [UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(changeCodeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:refreshBtn];
    [self showDefaultCode];
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    refreshBtn = [UIButton new];
    refreshBtn.backgroundColor = [UIColor clearColor];
    [refreshBtn addTarget:self action:@selector(changeCodeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:refreshBtn];
    [self showDefaultCode];
    
    return self;
}

- (void)showDefaultCode {
    codeArray = [NSArray arrayWithObjects:@"XJWD", @"FWD4", @"MW2D", @"6W7D", @"WD4C", @"W4DA", @"W93D", @"EJWD", @"WD3E", @"WUD7",nil];
    NSString *date =[[NSDate date] toString:@"MMddss"];
    NSInteger dateValue = [date integerValue];
    NSInteger index = dateValue % 10;
    
    NSString *code = [codeArray objectAtIndex:index];
    [self setupWithCode:code];
}

- (void)setupWithCode: (NSString *)verifyCode {
    if (STRING_NULL(verifyCode)) {
        return;
    }
    
    if (bgView) {
        [bgView removeFromSuperview];
    }
    bgView = [[UIView alloc]initWithFrame:self.bounds];
    [bgView setBackgroundColor:[self getRandomBgColorWithAlpha:0.8]];
    [self insertSubview:bgView belowSubview:refreshBtn];
    
    CGSize textSize = [@"W" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    //每个label能随机产生的位置的point.x的最大范围
    int randWidth = (self.frame.size.width)/verifyCode.length - textSize.width;
    //每个label能随机产生的位置的point.y的最大范围
    int randHeight = self.frame.size.height - textSize.height;
    
    for (int index = 0; index<verifyCode.length; index++) {
        //随机生成每个label的位置CGPoint(x,y)
        CGFloat px = arc4random()%randWidth + index*(self.frame.size.width-3)/verifyCode.length;
        CGFloat py = arc4random()%randHeight;
        UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(px+3, py, textSize.width, textSize.height)];
        label.text = [NSString stringWithFormat:@"%C",[verifyCode characterAtIndex:index]];
        label.font = [UIFont systemFontOfSize:20];
        //label倾斜斜的
        double r = (double)arc4random() / ARC4RAND_MAX * 2 - 1.0f;//随机生成-1到1的小数
        if (r>0.3) {
            r=0.3;
        }else if(r<-0.3){
            r=-0.3;
        }
        label.transform = CGAffineTransformMakeRotation(r);
        
        [bgView addSubview:label];
    }
    
    [self initLineBackgroundView];
}

//添加底部斜线
- (void)initLineBackgroundView {
    for (int i = 0; i < 10; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self getRandomBgColorWithAlpha:0.4] CGColor];//layer的边框色
        layer.lineWidth = arc4random() % 2 + 0.5;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        [bgView.layer addSublayer:layer];
    }
}

-(UIColor *)getRandomBgColorWithAlpha:(CGFloat)alpha{
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

- (void)layoutSubviews {
    refreshBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)changeCodeBtnPressed {
    if (self.delegate) {
        [_delegate needChangeVerifyCode];
    }
}

@end
