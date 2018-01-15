//
//  ProductMainView.m
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductMainView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProductSkuInfo.h"
#import "XLPhotoBrowser.h"
#import "ProductImageInfo.h"

@interface ProductMainView ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *specificationBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ProductMainView {
    ProductDetail *product;
    NSMutableArray *imageList; //图片列表；
    NSMutableArray *imageViewList; //
    BOOL downloadFinished;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ProductMainView" owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    imageList = [NSMutableArray new];
    imageViewList = [NSMutableArray new];
    
    //下拉刷新数据
//    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        if (_delegate) {
//            [_delegate refreshProductInfo];
//        }
//    }];
    
    //上拉切换页面
    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        if (_delegate) {
            [_delegate showProductDetail];
        }
        [self.scrollView.mj_footer endRefreshing];
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"上拉切换页面" forState:MJRefreshStatePulling];
    [footer setTitle:@"上拉切换页面" forState:MJRefreshStateRefreshing];
    self.scrollView.mj_footer = footer;
    
    downloadFinished = NO;
    _imageScroll.pagingEnabled = YES;
    _imageScroll.delegate = self;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPressed)];
    [_imageScroll addGestureRecognizer:gesture];
}

- (void)setupWithProduct:(ProductDetail *)detail {
    product = detail;
    [imageViewList removeAllObjects];
    [imageList removeAllObjects];
    
    //类型图片
    NSString *imageName = @"";
    switch (detail.productType) {
            case ProductType_Trade:
            imageName = @"product_damao";
            break;
            
            case ProductType_Bonded:
            imageName = @"product_baoshui";
            break;
            
            case ProductType_Deliver:
            imageName = @"product_zhiyou";
            break;
            
        default:
            break;
    }
    if (!STRING_NULL(imageName)) {
        _typeImage.image = UIImageWithName(imageName);
    }
    
    _titleLabel.text = detail.name;
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf", detail.price];
    float marketPrice = 0;
    for (ProductSkuInfo *sku in detail.appSkus) {
        if (!STRING_NULL(sku.marketPrice)) {
            float market = [sku.marketPrice floatValue];
            if (market > marketPrice) {
                marketPrice = market;
            }
        }
    }
    if (marketPrice != CGFLOAT_MAX) {
        _oldPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf", marketPrice];
    }
    
    //处理图片数组
    if (!product.productImages || [product.productImages count] == 0) {
        //ZC_DEBUG  return;
        product.productImages = @[product.image];
    }
    
    //pageControll 设置
    _pageControl.numberOfPages = [detail.productImages count];
    
    //图片排序
    [self sortProductImages];
    
    //图片显示
    NSInteger count = [product.productImages count];
    _imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH * count, SCREEN_WIDTH / 1.1);
    for (ProductImageInfo *imageInfo in product.productImages) {
        
        NSURL *imageUrl = [NSURL URLWithString:imageInfo.large];
        if (!imageUrl) {
            continue;
        }
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURL:imageUrl placeholderImage:UIImageWithName(@"default_5") options:SDWebImageProgressiveDownload];
        [_imageScroll addSubview:imageView];
        [imageViewList addObject:imageView];
        
        //异步下载图片
        __block NSURL *sourceUrl = [NSURL URLWithString:imageInfo.source];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:sourceUrl];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [imageList addObject:image];
            
            if ([imageList count] == count) {
                downloadFinished = YES;
            }
        });
    }
    
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageWidth = _imageScroll.frame.size.width;
    CGFloat imageHeight = _imageScroll.frame.size.height;
    
    NSInteger count = [imageViewList count];
    for (NSInteger index = 0; index < count; index++) {
        UIImageView *imageView = [imageViewList objectAtIndex:index];
        imageView.frame = CGRectMake(index * imageWidth, 0, imageWidth, imageHeight);
    }
}


- (IBAction)specificationBtnPressed:(id)sender {
    if (_delegate) {
        [_delegate showProductSpecifications];
    }
}

- (void)scrollViewPressed {
    CGFloat originX = _imageScroll.contentOffset.x;
    NSInteger index = originX / SCREEN_WIDTH;
    
    [XLPhotoBrowser showPhotoBrowserWithImages:imageList currentImageIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat originX = scrollView.contentOffset.x;
    
    _pageControl.currentPage = originX / SCREEN_WIDTH;
}

- (void)sortProductImages {
    NSMutableArray *sortedList = [NSMutableArray new];
    for (ProductImageInfo *info in product.productImages) {
        if (info.order == 0) {
            [sortedList addObject:info];
        }
        else {
            [sortedList insertObject:info atIndex:info.order];
        }
    }
    
    product.productImages = [sortedList copy];
}

@end
