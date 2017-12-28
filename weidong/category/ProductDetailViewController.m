//
//  ProductDetailViewController.m
//  weidong
//
//  Created by zhccc on 2017/10/19.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "GetProductDetailRequest.h"
#import "GetProductCommentRequest.h"
#import "GetProductConsultRequest.h"
#import "AddFavoriteProductReqeust.h"
#import "ProductMainView.h"
#import "LoginViewController.h"
#import "ProductDetailView.h"
#import "ProductCommentsView.h"
#import "ProductConsultsView.h"
#import "ProductSpecificationView.h"
#import "ProductConsulateViewController.h"
#import "ProductDetail.h"
#import "CommentInfo.h"

@interface ProductDetailViewController () <ProductDetailRefreshDelegate, ProductSpecificationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *excuteBtn;

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *homepageBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) UITabBarController *tabController;

@property (nonatomic, strong) ProductMainView *homeView;
@property (nonatomic, strong) ProductDetailView *detailView;
@property (nonatomic, strong) ProductCommentsView *commentView;
@property (nonatomic, strong) ProductConsultsView *consultView;
@property (nonatomic, strong) ProductSpecificationView *specView;

@end

@implementation ProductDetailViewController {
    ProductDetail *detail;
    NSArray *commentList;
    NSArray *consulations;
    
    NSInteger currState;    //0-商品首页；1-商品详情；2-商品评价；3-咨询界面
    BOOL didPressedConsult;
    
    CGFloat transHeight;
    CGFloat specHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品信息";
    [self initNaviBackButton];
    
    currState = 0;
    didPressedConsult = NO;
    
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getProductDetailInfo];
    [self getProductCommentsList];
    [self getProductConsulations];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    didPressedConsult = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    [self setupHeaderViews];
    self.mainView.clipsToBounds = YES;
    
    transHeight = self.mainView.bounds.size.height;
    
    //商品首页
    _homeView = [[ProductMainView alloc] initWithFrame:self.mainView.bounds];
    _homeView.delegate = self;
    [self.mainView addSubview:_homeView];
    
    //商品详情
    _detailView = [[ProductDetailView alloc] initWithFrame:self.mainView.bounds];
    _detailView.delegate = self;
    [self.mainView addSubview:_detailView];
    _detailView.transform = CGAffineTransformTranslate(_detailView.transform, 0, transHeight);
    
    //商品评论列表
    _commentView = [[ProductCommentsView alloc] initWithFrame:self.mainView.bounds];
    _commentView.delegate = self;
    [self.mainView addSubview:_commentView];
    _commentView.transform = CGAffineTransformTranslate(_commentView.transform, 0, transHeight);
    
    //商品咨询列表
    _consultView = [[ProductConsultsView alloc] initWithFrame:self.mainView.bounds];
    _consultView.delegate = self;
    [self.mainView addSubview:_consultView];
    _consultView.transform = CGAffineTransformTranslate(_consultView.transform, 0, transHeight);
    
    [self.mainView bringSubviewToFront:_homeView];
    
    [_homepageBtn adjustItemsUpDown];
    [_favoriteBtn adjustItemsUpDown];
    [_cartBtn     adjustItemsUpDown];
    
    _bottomView.layer.shadowColor = [UIColor grayColor].CGColor;
    _bottomView.layer.shadowRadius = 4.0;
    _bottomView.layer.shadowOpacity = 0.5;
    _bottomView.layer.shadowOffset = CGSizeMake(4, -4);
}

//MARK: 网络请求
- (void)getProductDetailInfo {
    GetProductDetailRequest *request = [GetProductDetailRequest new];
    request.productId = self.productId;
    [request excuteRequest:^(BOOL isOK, GetProductDetailResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            detail = response.detail;
            [_homeView setupWithProduct:detail];
            [_detailView setupWithProductDetail:detail];
            [_specView setupWithProduct:detail];
        }
    }];
}

//获取评论列表
- (void)getProductCommentsList {
    GetProductCommentRequest *request = [GetProductCommentRequest new];
    request.productId = self.productId;
    [request excuteRequest:^(BOOL isOK, GetProductCommentResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            commentList = response.list;
            [_commentView reloadTableDataWith:commentList];
            
            if (_showComment) {
                [self showProductComments];
                _showComment = NO;
            }
        }
    }];
}

//获取咨询列表
- (void)getProductConsulations {
    GetProductConsultRequest *request = [GetProductConsultRequest new];
    request.productId = self.productId;
    [request excuteRequest:^(BOOL isOK, GetProductConsultResponse * _Nullable response, NSString * _Nullable errorMsg) {
        if (isOK) {
            consulations = response.list;
            if (consulations && [consulations count]) {
                [_consultView reloadTableWithConsults:consulations];
            }
            
            if (_showConsulation) {
                [self showProductConsults];
                _showConsulation = NO;
            }
        }
    }];
}

//添加收藏
- (void)addProductToFavorite {
    AddFavoriteProductReqeust *request = [AddFavoriteProductReqeust new];
    request.productId = self.productId;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"添加收藏成功"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

//MARK: 按钮点击
- (IBAction)productHomeBtnPressed:(id)sender {
    [self showProductHome];
}

- (IBAction)detailBtnPressed:(id)sender {
    [self showProductDetail];
}

- (IBAction)commentBtnPressed:(id)sender {
    [self showProductComments];
}

- (IBAction)showConsultBtnPressed:(id)sender {
    [self showProductConsults];
}

- (IBAction)newConsultBtnPressed:(id)sender {
    if (!didPressedConsult) {
        didPressedConsult = YES;
        
        ProductConsulateViewController *consulateVC = [ProductConsulateViewController new];
        consulateVC.product = detail;
        [self.navigationController pushViewController:consulateVC animated:YES];
    }
}

- (IBAction)homePageBtnPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    UITabBarController *tabController = [Util getMainTabbarController];
    if (tabController) {
        [tabController setSelectedIndex:0];
    }
}

- (IBAction)favoriteBtnPressed:(id)sender {
    if (![Util userIsLogin]) {  //未登录则打开登录界面
        [SVProgressHUD showInfoWithStatus:@"登录后才可以添加收藏哦~"];
        [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector:@selector(openLoginVC) userInfo:nil repeats:NO];
        return;
    }
    
    //已登录则添加收藏
    [self addProductToFavorite];
}

- (IBAction)showCartBtnPressed:(id)sender {
    UITabBarController *tabController = [Util getMainTabbarController];
    if (tabController) {
        [tabController setSelectedIndex:2];
    }
}

- (IBAction)addCartBtnPressed:(id)sender {
    [self showProductSpecifications];
}

//MARK: ProductDetailRefreshDelegate
- (void)showProductSpecifications {
    CGFloat specWidth = SCREEN_WIDTH;
    specHeight = specWidth * 0.8;
    CGFloat specY = self.view.bounds.size.height - specHeight;
    _specView = [[ProductSpecificationView alloc] initWithFrame:CGRectMake(0, specY, specWidth, specHeight)];
    [self.view addSubview:_specView];
    [self.view bringSubviewToFront:_specView];
    _specView.transform = CGAffineTransformTranslate(_specView.transform, 0, specHeight + 30);
    _specView.delegate = self;
    
    if (detail) {
        [_specView setupWithProduct:detail];
    }
    
    [self moveVerticalTranslateView:_specView Distance:-specHeight-30];
}

//MARK: ProductSpecificationDelegate
- (void)closeSpecView {
    [self moveVerticalTranslateView:_specView Distance:specHeight+30];
}

- (void)refreshProductInfo {
    [self getProductDetailInfo];
    [self getProductCommentsList];
    [self getProductConsulations];
}

//MARK: 内部函数
- (void)showProductHome {
    if (currState == 0) {
        return;
    }
    
    [self hideCurrentViewToUp:NO];
    [self moveVerticalTranslateView:_homeView Distance:transHeight];
    
    currState = 0;
    [self setupHeaderViews];
}

- (void)showProductDetail {
    if (currState == 1) {
        return;
    }
    
    BOOL isUp = currState < 1 ? YES : NO;
    [self hideCurrentViewToUp:isUp];
    [_detailView setupWithProductDetail:detail];
    
    CGFloat originY = _detailView.frame.origin.y;
    CGFloat heigth = originY > 0 ? -transHeight : transHeight;
    [self moveVerticalTranslateView:_detailView Distance:heigth];
    
    currState = 1;
    [self setupHeaderViews];
}

- (void)showProductComments {
    if (currState == 2) {
        return;
    }
    
    BOOL isUp = currState < 2 ? YES : NO;
    [self hideCurrentViewToUp:isUp];
    
    if (commentList && [commentList count]) {
        [_commentView reloadTableDataWith:commentList];
    }
    
    CGFloat originY = _commentView.frame.origin.y;
    CGFloat heigth = originY > 0 ? -transHeight : transHeight;
    [self moveVerticalTranslateView:_commentView Distance:heigth];
    
    currState = 2;
    [self setupHeaderViews];
}

- (void)showProductConsults {
    if (currState == 3) {
        return;
    }
    
    [self hideCurrentViewToUp:YES];
    
    if (consulations && [consulations count]) {
        [_consultView reloadTableWithConsults:consulations];
    }
    [self moveVerticalTranslateView:_consultView Distance:-transHeight];
    
    currState = 3;
    [self setupHeaderViews];
}

- (void)setupHeaderViews {
    [_homeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_detailBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_consultBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    switch (currState) {
        case 0:
            [_homeBtn setTitleColor:POSITIVE_COLOR forState:UIControlStateNormal];
            break;
            
        case 1:
            [_detailBtn setTitleColor:POSITIVE_COLOR forState:UIControlStateNormal];
            [_excuteBtn setHidden:YES];
            break;
            
        case 2:
            [_commentBtn setTitleColor:POSITIVE_COLOR forState:UIControlStateNormal];
            [_excuteBtn setHidden:YES];
            break;
            
        case 3:
            [_consultBtn setTitleColor:POSITIVE_COLOR forState:UIControlStateNormal];
            [_excuteBtn setHidden:NO];
            break;
            
        default:
            break;
    }
    
    [_excuteBtn setHidden:(currState != 3)];
}

//点击不同界面后，隐藏当前界面 toUp:YES 向上隐藏； toUp：NO 向下隐藏
- (void)hideCurrentViewToUp:(BOOL)toUp {
    CGFloat heigth = toUp ? -transHeight : transHeight;
    switch (currState) {
        case 0:
            [self moveVerticalTranslateView:_homeView Distance:heigth];
            break;
        case 1:
            [self moveVerticalTranslateView:_detailView Distance:heigth];
            break;
        case 2:
            [self moveVerticalTranslateView:_commentView Distance:heigth];
            break;
        case 3:
            [self moveVerticalTranslateView:_consultView Distance:heigth];
            break;
            
        default:
            break;
    }
}

- (void)moveVerticalTranslateView:(UIView *)view Distance:(CGFloat)distance {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.transform = CGAffineTransformTranslate(view.transform, 0, distance);
    } completion:nil];
}

- (void)openLoginVC {
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:NO];
}

@end
