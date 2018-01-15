//
//  AddressEditViewController.m
//  weidong
//
//  Created by zhccc on 2017/11/20.
//  Copyright © 2017年 zhccc. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AddAddressRequest.h"
#import "UpdateAddressRequest.h"
#import "GetAreaListRequest.h"

#import "AreaInfo.h"

@interface AddressEditViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtLabel;

@property (weak, nonatomic) IBOutlet UIView *bgProvinceVIew;
@property (weak, nonatomic) IBOutlet UIView *bgCityView;
@property (weak, nonatomic) IBOutlet UIView *bgDistrictView;
@property (weak, nonatomic) IBOutlet UIImageView *dropIcon0;
@property (weak, nonatomic) IBOutlet UIImageView *dropIcon1;
@property (weak, nonatomic) IBOutlet UIImageView *dropIcon2;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *funcBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation AddressEditViewController {
    BOOL isDefault;
    NSString *selectProvinceId;
    NSString *provinceName;
    NSString *selectCityId;
    NSString *cityName;
    NSString *selectDistrictId;
    NSString *districtName;
    NSInteger pickerType; //0-省、1-市、 2-区
    
    NSArray *provinceList;
    NSArray *cityList;
    NSArray *districtList;
    
    UIView *areaPicker;
    UIPickerView *picker;
    CGFloat pickerHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviBackButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.title = _address ? @"修改收货地址" : @"添加收货地址";
    
    isDefault = NO;
    pickerType = 0;
    pickerHeight = SCREEN_WIDTH * 0.8;
    
    [self initSubViews];
    [self initAreaPickerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getProvinceListRequest];
    if (_address) {
        [self getCityListRequest];
        [self getDistrictListRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    //设置地址选择按钮的下拉三角颜色
    [_dropIcon0 setTintColor:POSITIVE_COLOR];
    [_dropIcon1 setTintColor:POSITIVE_COLOR];
    [_dropIcon2 setTintColor:POSITIVE_COLOR];
    
    //圆角框
    [_bgProvinceVIew setRoundBorder];
    [_bgCityView setRoundBorder];
    [_bgDistrictView setRoundBorder];
    
    //底部 确认、取消按钮颜色
    [self setupPositiveButtonStyle:_funcBtn];
    [self setupNegativeButtonStyle:_cancelBtn];
    
    
    if (!_address) {   //新建地址界面先隐藏城市和区域
        [_bgCityView setHidden:YES];
        [_bgDistrictView setHidden:YES];
    }
    else { //编辑地址 数据初始化
        _nameTF.text = _address.consignee;
        _addressTF.text = _address.address;
        _zipCodeTF.text = _address.zipCode;
        _phoneTF.text = _address.phone;
        _provinceLabel.text = _address.provinceAreaName;
        _cityLabel.text = _address.cityAreaName;
        _districtLabel.text = _address.countyAreaName;
        
        selectProvinceId = _address.provinceAreaId;
        selectCityId = _address.cityAreaId;
        selectDistrictId = _address.countyAreaId;
        
        isDefault = _address.isDefault;
        [self updateDefaultBtnLayout];
    }
}

- (void)showAreaPickerView {
//    [picker selectRow:0 inComponent:0 animated:NO];
    [UIView animateWithDuration:0.3 animations:^{
        areaPicker.transform = CGAffineTransformIdentity;
    }];
}

- (void)confirmAreaSelection {
    [UIView animateWithDuration:0.3 animations:^{
        areaPicker.transform = CGAffineTransformTranslate(areaPicker.transform, 0, pickerHeight);
    }];
    
    if (pickerType == 0) {
        _provinceLabel.text = provinceName;
        _cityLabel.text = @"选择城市";
        _districtLabel.text = @"选择区县";
        cityName = nil;
        districtName = nil;
        
        [_bgCityView setHidden:NO];
        [_bgDistrictView setHidden:YES];
        
        [self getCityListRequest];
    }
    else if (pickerType == 1) {
        _cityLabel.text = cityName;
        _districtLabel.text = @"选择区县";
        districtName = nil;
        
        [_bgDistrictView setHidden:NO];
        
        [self getDistrictListRequest];
    }
    else {
        _districtLabel.text = districtName;
    }
}

- (IBAction)provinceSelectBtnPressed:(id)sender {
    [_nameTF resignFirstResponder];
    
    if (![provinceList count]) {
        [SVProgressHUD showInfoWithStatus:@"正在请求数据，请稍后"];
        return;
    }
    
    pickerType = 0;
//    AreaInfo *area = [provinceList objectAtIndex:0];
//    selectProvinceId = area.areaId;
    [picker reloadAllComponents];
    [self showAreaPickerView];
}

- (IBAction)citySelectBtnPressed:(id)sender {
    if (![cityList count]) {
        [SVProgressHUD showInfoWithStatus:@"正在请求数据，请稍后"];
        return;
    }
    
    pickerType = 1;
//    AreaInfo *area = [cityList objectAtIndex:0];
//    selectCityId = area.areaId;
    [picker reloadAllComponents];
    [self showAreaPickerView];
}

- (IBAction)districtBtnPressed:(id)sender {
    if (![districtList count]) {
        [SVProgressHUD showInfoWithStatus:@"正在请求数据，请稍后"];
        return;
    }
    
    pickerType = 2;
//    AreaInfo *area = [districtList objectAtIndex:0];
//    selectDistrictId = area.areaId;
    [picker reloadAllComponents];
    [self showAreaPickerView];
}

- (IBAction)defaultBtnPressed:(id)sender {
    isDefault = !isDefault;
    [self updateDefaultBtnLayout];
}

- (IBAction)functionBtnPressed:(id)sender {
    NSString *name = _nameTF.text;
    NSString *addressDetail = _addressTF.text;
    NSString *zipCode = _zipCodeTF.text;
    NSString *phone = _phoneTF.text;
    
    
    if (STRING_NULL(name)) {
        [SVProgressHUD showInfoWithStatus:@"请输入收件人姓名"];
        return;
    }
    
    if (STRING_NULL(provinceName)) {
        [SVProgressHUD showInfoWithStatus:@"请选择省份"];
        return;
    }
    
    if (STRING_NULL(cityName)) {
        [SVProgressHUD showInfoWithStatus:@"请选择城市"];
        return;
    }
    
    if (STRING_NULL(districtName)) {
        [SVProgressHUD showInfoWithStatus:@"请选择区县"];
        return;
    }
    
    if (STRING_NULL(addressDetail)) {
        [SVProgressHUD showInfoWithStatus:@"请输入详细地址"];
        return;
    }
    
    if (STRING_NULL(zipCode)) {
        [SVProgressHUD showInfoWithStatus:@"请输入邮政编码"];
        return;
    }
    
    if ([zipCode length] != 6) {
        [SVProgressHUD showInfoWithStatus:@"邮政编码应为6位数字"];
        return;
    }
    
    if (STRING_NULL(phone)) {
        [SVProgressHUD showInfoWithStatus:@"请输入收件人联系电话"];
        return;
    }
    
    if ([phone length] < 8) {
        [SVProgressHUD showInfoWithStatus:@"请输入有效的电话/手机号码"];
        return;
    }
    
    if (_address) {
        [self updateAddress];
    }
    else {
        [self addNewAddress];
    }
}

- (IBAction)cancelBtnPressed:(id)sender {
    //如果什么也没写 就直接退出
    NSString *name = _nameTF.text;
    NSString *addressDetail = _addressTF.text;
    NSString *zipCode = _zipCodeTF.text;
    NSString *phone = _phoneTF.text;
    if (STRING_NULL(name) &&
        STRING_NULL(addressDetail) &&
        STRING_NULL(zipCode) &&
        STRING_NULL(phone) ) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSString *title = @"确定要退出本次编辑吗？";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"继续编辑" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)getProvinceListRequest {
    GetAreaListRequest *request = [GetAreaListRequest new];
    [request excuteRequest:^(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg) {
        if (isOK) {
            provinceList = list;
        }
    }];
}

- (void)getCityListRequest {
    if (STRING_NULL(selectProvinceId)) {
        return;
    }
    GetAreaListRequest *request = [GetAreaListRequest new];
    request.parentId = selectProvinceId;
    [request excuteRequest:^(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg) {
        if (isOK) {
            cityList = list;
        }
    }];
}

- (void)getDistrictListRequest {
    if (STRING_NULL(selectCityId)) {
        return;
    }
    GetAreaListRequest *request = [GetAreaListRequest new];
    request.parentId = selectCityId;
    [request excuteRequest:^(BOOL isOK, NSArray * _Nullable list, NSString * _Nullable errorMsg) {
        if (isOK) {
            districtList = list;
        }
    }];
}

- (void)updateDefaultBtnLayout {
    if (isDefault) {
        [_defaultBtn setImage:[UIImage imageNamed:@"btn_checked"] forState:UIControlStateNormal];
    }
    else {
        [_defaultBtn setImage:[UIImage imageNamed:@"btn_uncheck"] forState:UIControlStateNormal];
    }
}


//MARK: - delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerType == 0) {
        return [provinceList count];
    }
    if (pickerType == 1) {
        return [cityList count];
    }
    return [districtList count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerType == 0) {
        AreaInfo *area = [provinceList objectAtIndex:row];
        return area.name;
    }
    if (pickerType == 1) {
        AreaInfo *area = [cityList objectAtIndex:row];
        return area.name;
    }
    AreaInfo *area = [districtList objectAtIndex:row];
    return area.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerType == 0) {
        AreaInfo *province = [provinceList objectAtIndex:row];
        selectProvinceId = province.areaId;
        provinceName = province.name;
    }
    else if (pickerType == 1) {
        AreaInfo *city = [cityList objectAtIndex:row];
        selectCityId = city.areaId;
        cityName = city.name;
    }
    else {
        AreaInfo *district = [districtList objectAtIndex:row];
        selectDistrictId = district.areaId;
        districtName = district.name;
    }
}



- (void)initAreaPickerView {
    areaPicker = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGH - pickerHeight, SCREEN_WIDTH, pickerHeight)];
    areaPicker.backgroundColor = [UIColor whiteColor];
    areaPicker.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    areaPicker.layer.shadowRadius = 4.0;
    areaPicker.layer.shadowOpacity = 0.5;
    areaPicker.layer.shadowOffset = CGSizeMake(2, -4);
    [self.view addSubview:areaPicker];
    
    CGFloat btnHeight = 30;
    CGFloat margin = 4;
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH - margin * 2, pickerHeight - margin * 2 - btnHeight)];
    picker.delegate = self;
    picker.dataSource = self;
    [areaPicker addSubview:picker];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, btnHeight)];
    confirmBtn.center = CGPointMake(SCREEN_WIDTH / 2, pickerHeight - margin - btnHeight);
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.backgroundColor = POSITIVE_COLOR;
    confirmBtn.layer.cornerRadius = 6.0;
    [confirmBtn addTarget:self action:@selector(confirmAreaSelection) forControlEvents:UIControlEventTouchUpInside];
    [areaPicker addSubview:confirmBtn];
    
    //隐藏picker
    areaPicker.transform = CGAffineTransformTranslate(picker.transform, 0, pickerHeight);
}

- (void)addNewAddress {
    NSString *name = _nameTF.text;
    NSString *addressDetail = _addressTF.text;
    NSString *zipCode = _zipCodeTF.text;
    NSString *phone = _phoneTF.text;
    NSString *fullAera = [NSString stringWithFormat:@"%@,%@,%@", provinceName, cityName, districtName];
    
    [SVProgressHUD showWithStatus:@"正在上传"];
    DeliverAddressInfo *addressInfo = [DeliverAddressInfo new];
    addressInfo.consignee = name;
    addressInfo.areaName  = fullAera;
    addressInfo.phone     = phone;
    addressInfo.address   = addressDetail;
    addressInfo.zipCode   = zipCode;
    addressInfo.areaId    = selectDistrictId;
    addressInfo.isDefault = isDefault;
    AddAddressRequest *request = [AddAddressRequest new];
    request.addressInfo = addressInfo;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

- (void)updateAddress {
    NSString *name = _nameTF.text;
    NSString *addressDetail = _addressTF.text;
    NSString *zipCode = _zipCodeTF.text;
    NSString *phone = _phoneTF.text;
    NSString *fullAera = [NSString stringWithFormat:@"%@,%@,%@", provinceName, cityName, districtName];
    
    [SVProgressHUD showWithStatus:@"正在更新"];
    _address.consignee = name;
    _address.areaName  = fullAera;
    _address.phone     = phone;
    _address.address   = addressDetail;
    _address.zipCode   = zipCode;
    _address.areaId    = selectDistrictId;
    _address.isDefault = isDefault;
    UpdateAddressRequest *request = [UpdateAddressRequest new];
    request.addressInfo = _address;
    [request excuteRequest:^(BOOL isOK, NSString * _Nullable errorMsg) {
        [SVProgressHUD dismiss];
        if (isOK) {
            [SVProgressHUD showSuccessWithStatus:@"更新成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [SVProgressHUD showErrorWithStatus:errorMsg];
        }
    }];
}

@end
