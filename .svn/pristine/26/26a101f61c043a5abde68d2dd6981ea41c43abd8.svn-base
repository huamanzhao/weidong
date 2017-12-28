//
//  ProductSpecificationView.m
//  weidong
//
//  Created by zhccc on 2017/11/18.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "ProductSpecificationView.h"
#import "ProductSkuInfo.h"
#import "ProductSpecValue.h"
#import "ProductSpec.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TitleCollectionCell.h"
#import "AddCartInfoRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "CartItemInfo.h"
#import "AddProductNotifyReqeust.h"

@interface ProductSpecificationView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *specificationNameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *quantityTF;
@property (weak, nonatomic) IBOutlet UIButton *addCartBtn;
@end

@implementation ProductSpecificationView {
    ProductDetail *detail;
    NSString *cellIdentifier;
    
    NSInteger selectIndex;  //选中sku的序号
    NSInteger quantity;
    BOOL inUploading;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"ProductSpecificationView" owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    selectIndex = 0;
    quantity = 1;
    inUploading = NO;
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowRadius = 4.0;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(1, -4);
    
    _productImage.layer.borderColor = [UIColor whiteColor].CGColor;
    _productImage.layer.borderWidth = 2.0;
    
    cellIdentifier = @"specId";
    [_collectionView registerClass:[TitleCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
}

- (void)setupWithProduct:(ProductDetail *)productDetail {
    detail = productDetail;
    
    NSString *imageUrlStr = detail.image;
    NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
    if (imageUrl) {
        [_productImage sd_setImageWithURL:imageUrl placeholderImage:UIImageWithName(@"default_1") options:SDWebImageProgressiveDownload];
    }
    
    [self setupViewData];
    
    if ([detail.specificationItems count] > 0) {
        ProductSpec *spec = detail.specificationItems.firstObject;
        _specificationNameLabel.text = spec.name;
    }
    
    [_collectionView reloadData];
}

- (IBAction)closeBtnPressed:(id)sender {
    if (self.delegate) {
        [self.delegate closeSpecView];
    }
}

- (IBAction)minusBtnPressed:(id)sender {
    if (quantity == 1) {
        return;
    }
    quantity = quantity - 1;
    [self updateQuatityTextfield];
}

- (IBAction)addBtnPressed:(id)sender {
    quantity = quantity + 1;
    [self updateQuatityTextfield];
}

- (IBAction)addCartBtnPressed:(id)sender {
    //判断商品库存
    ProductSkuInfo *sku = [detail.appSkus objectAtIndex:selectIndex];
    if (sku.stock <= 0) {
        [self showNoQuantityAlert];
        return;
    }
    
    if (inUploading) {
        return;
    }
    
    inUploading = YES;
    
    //判断用户是否已登录，如果已登录则添加到服务端；未登录则添加到本地
    if ([Util userIsLogin]) {
        [self addSeverCart];
    }
    else {
        [self addLocalCart];
    }
}

- (void)addLocalCart {
    ProductSkuInfo *sku = [detail.appSkus objectAtIndex:selectIndex];
    
    CartItemInfo *cartItem = [CartItemInfo new];
    cartItem.skuId = sku.id;
    ProductSpecValue *spec = sku.specificationValues.firstObject;
    cartItem.skuName = spec.value;
    cartItem.price = sku.price;
    cartItem.productName = detail.name;
    cartItem.productId = detail.id;
    cartItem.quantity = quantity;
    cartItem.productType = detail.productType;
    cartItem.skuThumbnail = detail.image;
    [cartItem addLocalRecord];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(showSuccessInfo) userInfo:nil repeats:NO];
}

- (void)showSuccessInfo {
    [SVProgressHUD showSuccessWithStatus:@"添加购物车成功"];
    inUploading = NO;
}

- (void)addSeverCart {
    [SVProgressHUD showWithStatus:@"正在添加"];
    ProductSkuInfo *sku = [detail.appSkus objectAtIndex:selectIndex];
    AddCartInfoRequest *request = [AddCartInfoRequest new];
    request.skuId = sku.id;
    request.quantity = quantity;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        inUploading = NO;
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!detail) {
        return 0;
    }
    return [detail.appSkus count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    ProductSkuInfo *sku = [detail.appSkus objectAtIndex:indexPath.row];
    if ([sku.specificationValues count] > 0) {
        ProductSpecValue *specValue = sku.specificationValues.firstObject;
        [cell setupWithTitle:specValue.value];
    }
    if (indexPath.row == 0) {
        cell.usrSelect = YES;
        [cell setupSelectLayout];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    CGFloat itemHeight = 32;
    ProductSkuInfo *skuInfo = [detail.appSkus objectAtIndex:row];
    if ([skuInfo.specificationValues count] >0) {
        ProductSpecValue *specValue = skuInfo.specificationValues.firstObject;
        NSString *value = specValue.value;
        CGSize defaultSize = CGSizeMake(400, 24);
        CGFloat textWidth = [Util getTextBoundSize:value Font:[UIFont systemFontOfSize:14.0] Size:defaultSize].width;
        
        return CGSizeMake(textWidth + 16, itemHeight);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (TitleCollectionCell *cell in collectionView.visibleCells) {
        cell.usrSelect = NO;
        [cell setupSelectLayout];
    }
    
    selectIndex = indexPath.row;
    TitleCollectionCell *cell = (TitleCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.usrSelect = YES;
    
    [self setupViewData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (STRING_NULL(textField.text)) {
        return;
    }
    
    NSInteger textValue = [textField.text integerValue];
    if (textValue) {
        quantity = textValue;
        [self updateQuatityTextfield];
    }
}

- (void)setupViewData {
    ProductSkuInfo *skuInfo = [detail.appSkus objectAtIndex:selectIndex];
    float priceValue = [skuInfo.price floatValue];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", priceValue];
    float marketValue = [skuInfo.marketPrice floatValue];
    _marketLabel.text = [NSString stringWithFormat:@"￥%.2f", marketValue];
    
}

- (void)updateQuatityTextfield {
    _quantityTF.text = [NSString stringWithFormat:@"%ld", (long)quantity];
}

- (void)showNoQuantityAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该商品库存不足" message:@"是否添加到货通知？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入到货通知邮箱";
        if ([Util userIsLogin]) {
            NSString *email = [Util getUserEmail];
            if (!STRING_NULL(email)) {
                textField.text = email;
            }
        }
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [alert.textFields objectAtIndex:0];
        [self addProductNotifyWithEmail:textField.text];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [[Util getTopViewController].navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)addProductNotifyWithEmail:(NSString *)email {
    if (STRING_NULL(email)) {
        [SVProgressHUD showInfoWithStatus:@"请输入您的邮箱账号"];
        return;
    }
    if (![email checkEmailAccount]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的邮箱账号"];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"正在添加"];
    ProductSkuInfo *skuInfo = [detail.appSkus objectAtIndex:selectIndex];
    AddProductNotifyReqeust *request = [AddProductNotifyReqeust new];
    request.email = email;
    request.skuId = skuInfo.id;
    [request excuteRequest:^(BOOL isOK, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功，到货后会给您发邮件"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"添加到货通知失败,原因：%@", errorMsg]];
        }
    }];
}

@end
