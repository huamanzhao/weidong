//
//  BadgeButton.m
//  BudgeButton
//
//  Created by zhouch on 2017/11/10.
//  Copyright © 2017年 hbfec. All rights reserved.
//

#import "BadgeButton.h"

@interface BadgeView : UIView
- (void)setNumber:(NSInteger)number;
@end

@implementation UIButton(BadgeButton)

- (void)setBadge:(NSInteger)number {
    BadgeView *badge;
    //查找当前角标view，找不到就创建一个新的
    for (UIView *sub in self.subviews) {
        if ([sub isKindOfClass:[BadgeView class]]) {
            badge = (BadgeView *)sub;
        }
    }
    if (!badge) {
        badge = [BadgeView new];
        badge.backgroundColor = [UIColor clearColor];
        [self addSubview:badge];
    }
    
    CGFloat imageX = self.imageView.frame.origin.x;
    CGFloat imageY = self.imageView.frame.origin.y;
    CGFloat imgWidth = self.imageView.frame.size.width;
    
    CGFloat badgeLen = 18;  //角标宽高
    CGFloat badgeX = imageX + imgWidth - badgeLen / 2;
    badge.frame = CGRectMake(badgeX, imageY - badgeLen / 2, badgeLen, badgeLen);
    
    if (number == 0) {
        [badge setHidden:YES];
    }
    else {
        [badge setHidden:NO];
        [badge setNumber:number];
    }
}


@end

//自定义的角标view
@implementation BadgeView {
    NSInteger badgeNum;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //填充色
    UIColor *red = [UIColor redColor];
    [red set];
    UIBezierPath *bPath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [bPath fill];
    
    UIFont *font = [UIFont systemFontOfSize:12.0];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.alignment = NSTextAlignmentCenter;
    NSString *numStr = [NSString stringWithFormat:@"%ld", (long)badgeNum];
    
    CGRect numRect = rect;
    numRect.origin.y = rect.origin.y + 2;
    [numStr drawInRect:numRect withAttributes:@{NSFontAttributeName : font,
                                             NSForegroundColorAttributeName : [UIColor whiteColor],
                                             NSParagraphStyleAttributeName : style
                                             }];
}

- (void)setNumber:(NSInteger)number {
    badgeNum = number;
    
    [self setNeedsDisplay];
}
@end
