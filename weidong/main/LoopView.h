//
//  LoopView.h
//  GZDefence
//
//  Created by zhccc on 2017/8/24.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoopDelegate <NSObject>
//点按选择新闻
- (void)selectPromotionWithId: (NSString *)promotionId;

@end

@protocol TitleViewDelegate <NSObject>

- (void)itemDidSelected: (NSString *)promotionId;

@end

@interface LoopView : UIView <UIScrollViewDelegate, TitleViewDelegate>

@property (nonatomic, weak) id <LoopDelegate> delegate;

- (void)showViewWithPromotions: (NSArray *)list;

@end
