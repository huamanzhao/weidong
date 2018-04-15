//
//  BannerView.m
//  GZDefence
//
//  Created by zhccc on 2017/8/23.
//  Copyright © 2017年 wxy. All rights reserved.
//

#import "BannerView.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AdInfo.h"

@implementation BannerView {
    UIScrollView *_scrollView;
    UIPageControl *pageControl;
    
    NSMutableArray *imageList;
    NSArray *banners;
    NSUInteger bannersCount;
    
    CGFloat width;
    CGFloat height;
    
    NSTimer *timer;
    UITapGestureRecognizer *tapGesture;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        width = frame.size.width;
        height = frame.size.height;
        
        [self initSubViews];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSubViews];
    }
    
    return self;
}

- (void)initSubViews {
    //scrollView
    _scrollView = [UIScrollView new];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    //pageControll
    pageControl = [UIPageControl new];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [[UIColor colorWithHex:0xb8ee6e] colorWithAlphaComponent:0.8];
    [self addSubview:pageControl];
    
    //手势
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerSelected)];
    [_scrollView addGestureRecognizer:tapGesture];
}

- (void)showViewWithBanners: (NSArray *)bannerList {
    if (!bannerList || [bannerList count] == 0) {
        return;
    }
    
    bannersCount = [bannerList count];
    pageControl.numberOfPages = bannersCount;
    
    banners = bannerList;
    imageList = [NSMutableArray new];
    for (UIView *sub in _scrollView.subviews) {
        if ([sub isKindOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)sub;
            if (imageView.image != nil) {
                [imageView removeFromSuperview];
            }
        }
    }
    
    for (AdInfo *info in bannerList) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:info.path] placeholderImage:UIImageWithName(@"img_default") options:SDWebImageRetryFailed];
        
        [imageList addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    
    //为了实现循环演示，最后一个图片再添加一次
    AdInfo *first = bannerList.firstObject;
    UIImageView *firstImage = [UIImageView new];
    firstImage.contentMode = UIViewContentModeScaleAspectFill;
    firstImage.clipsToBounds = YES;
    [firstImage sd_setImageWithURL:[NSURL URLWithString:first.path] placeholderImage:UIImageWithName(@"img_default") options:SDWebImageRetryFailed];
    
    [imageList addObject:firstImage];
    [_scrollView addSubview:firstImage];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if (!timer) {
        [self startTimer];
    }
}

- (void)layoutSubviews {
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    _scrollView.frame = CGRectMake(0, 0, width, height);
    _scrollView.contentSize = CGSizeMake((width * bannersCount + 1), height);
    
    CGFloat pageHeight = 40;
    pageControl.frame = CGRectMake(0, 0, 180, pageHeight);
    pageControl.center = CGPointMake(width / 2, height - pageHeight / 2);
    
    for (int i = 0; i <= bannersCount; i++) {
        UIImageView *imageView = imageList[i];
        
        imageView.frame = CGRectMake(width * i, 0, width, height);
    }
    
    _scrollView.contentSize = CGSizeMake((bannersCount + 1) * width, height);
}

- (void)bannerSelected {
    if (self.delegate) {
        int index = _scrollView.contentOffset.x / width;
        AdInfo *adInfo= [banners objectAtIndex:index];
        
        [self.delegate selectAdWithId:adInfo];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    pageControl.currentPage = (NSInteger)(_scrollView.contentOffset.x / width);;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat orginX = scrollView.contentOffset.x;
    NSInteger pageIndex = (NSInteger)(orginX / width);
    if (pageIndex == bannersCount) {
        pageIndex = 0;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    [self startTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    CGFloat orginX = scrollView.contentOffset.x;
    NSInteger pageIndex = (NSInteger)(orginX / width);
    if (pageIndex == bannersCount) {
        pageIndex = 0;
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
    [self startTimer];
}

- (void)startTimer {
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(startLoopAnimation) userInfo:nil repeats:NO];
}

//执行循环动画
- (void)startLoopAnimation {
    NSInteger index = (NSInteger)(_scrollView.contentOffset.x / width);
    
    CGFloat offsetX = (index + 1) * width;
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

@end
