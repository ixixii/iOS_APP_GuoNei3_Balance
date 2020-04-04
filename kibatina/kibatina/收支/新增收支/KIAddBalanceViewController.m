//
//  KIAddBalanceViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/25.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIAddBalanceViewController.h"
#import "CXDatePickerView.h"
#import "KIMessageTool.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger, pickerType){
  pickerType_type = 1,
  pickerType_faimily
};

@interface KIAddBalanceViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *_typeArr;
    NSArray *_familyArr;
    NSInteger *_currentType;
}
@end

@implementation KIAddBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加收支";
    // 返回按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _typeArr = @[@"收入", @"支出"];
    _familyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_familyArr"];
    
    // 数据回显
    if(_model){
        self.title = @"收支详情";
        _xib_textField_name.text = _model[@"name"];
        _xib_textField_type.text = _model[@"type"];
        _xib_textField_amount.text = _model[@"amount"];
        _xib_textField_date.text = _model[@"date"];
        _xib_textField_family.text = _model[@"family"];
        _xib_textField_remark.text = _model[@"remark"];
        
        _xib_button_add.hidden = YES;
        
        _xib_button_type.userInteractionEnabled = NO;
        _xib_button_family.userInteractionEnabled = NO;
        _xib_button_date.userInteractionEnabled = NO;
        
        _xib_imageView_1.hidden = YES;
        _xib_imageView_2.hidden = YES;
        _xib_imageView_3.hidden = YES;
        
        _xib_textField_name.userInteractionEnabled = NO;
        _xib_textField_amount.userInteractionEnabled = NO;
        _xib_textField_remark.userInteractionEnabled = NO;
    }
}

#pragma mark - 输入金额
- (BOOL)onlyInputTheNumber:(NSString*)string{
    NSString *numString =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numString];
    BOOL inputString = [predicate evaluateWithObject:string];
    return inputString;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *targetString = [textField.text stringByAppendingString:string];
    if ([self onlyInputTheNumber:string] || [string isEqualToString:@"."]) {
        //检测“.”的个数
        NSString *temp = [NSString string];
        NSString *decimalsStr = [NSString string];
        NSInteger pointNum = 0;
        for(int i = 0; i < [targetString length];i++) {
            temp = [targetString substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:@"."]) {
                //切割小数点之后的字符串
                decimalsStr = [targetString substringFromIndex:i+1];
                pointNum ++;
            }
        }
        //如果输入了两个小数点或者小数点后面多于两位，禁止输入
        if (pointNum <= 1 && decimalsStr.length <= 2) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

#pragma mark - btn 事件
- (void)btnDateClicked:(UIButton *)btn
{
    [self.view endEditing:YES];
    CXDatePickerView *datepicker = [[CXDatePickerView alloc] initWithDateStyle:CXDateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
      NSString *dateString = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        _xib_textField_date.text = dateString;
    }];
    datepicker.dateLabelColor = kColor(253,176,72);//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.headerViewColor = kColor(253,176,72); // 顶部视图背景颜色
    datepicker.shadeViewAlphaWhenShow = 0.3;
    datepicker.showAnimationTime = 0.4;
    [datepicker show];
}

#pragma mark - btn 事件
- (void)addBtnClicked:(UIButton *)sender
{
    if(_xib_textField_name.text.length == 0){
        [KIMessageTool showKIMessage:@"收支名称不能为空"];
        return;
    }
    if(_xib_textField_type.text.length == 0){
        [KIMessageTool showKIMessage:@"收支分类不能为空"];
        return;
    }
    if(_xib_textField_amount.text.length == 0){
        [KIMessageTool showKIMessage:@"收支金额不能为空"];
        return;
    }
    if(_xib_textField_date.text.length == 0){
        [KIMessageTool showKIMessage:@"收支日期不能为空"];
        return;
    }
    if(_xib_textField_family.text.length == 0){
        [KIMessageTool showKIMessage:@"所属家人不能为空"];
        return;
    }
    
    NSString *tmpRemark = _xib_textField_remark.text;
    if(_xib_textField_remark.text.length == 0){
        tmpRemark = @"--";
    }
    
    // 存入本地plist
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *balanceArr = [userDefault objectForKey:@"userDefault_balanceArr"];
    NSDictionary *newBalance = @{
        @"name": _xib_textField_name.text,
        @"type": _xib_textField_type.text,
        @"amount": _xib_textField_amount.text,
        @"date": _xib_textField_date.text,
        @"family": _xib_textField_family.text,
        @"remark": tmpRemark
    };
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:balanceArr];
    [mArr addObject:newBalance];
    [userDefault setObject:mArr forKey:@"userDefault_balanceArr"];
    [userDefault synchronize];
    [KIMessageTool showKIMessage:@"提交中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KIMessageTool showKIMessage:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

#pragma mark - PickerView相关事件
- (void)btnTypeClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    _currentType = pickerType_type;
    
    _xib_button_mask.hidden = NO;
    _xib_button_cancel.hidden = NO;
    _xib_button_confirm.hidden = NO;
    _xib_label_toolbar.hidden = NO;
    _xib_pickerView.hidden = NO;
    
    _xib_label_toolbar.text = @"请选择收支分类";
    
    [_xib_pickerView reloadAllComponents];
    
}
- (void)btnFamilyClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    
    _currentType = pickerType_faimily;
    
    _xib_button_mask.hidden = NO;
    _xib_button_cancel.hidden = NO;
    _xib_button_confirm.hidden = NO;
    _xib_label_toolbar.hidden = NO;
    _xib_pickerView.hidden = NO;
    
    _xib_label_toolbar.text = @"请选择所属家人";
    
    [_xib_pickerView reloadAllComponents];
    
}
- (IBAction)maskBtnClicked:(UIButton *)sender
{
    [self abstract_hidePickView];
}
- (void)abstract_hidePickView
{
    _currentType = 0;
    
    _xib_button_mask.hidden = YES;
    _xib_button_cancel.hidden = YES;
    _xib_button_confirm.hidden = YES;
    _xib_label_toolbar.hidden = YES;
    _xib_pickerView.hidden = YES;
    
    _xib_label_toolbar.text = @"";
}
- (IBAction)cancelBtnClicked:(UIButton *)sender
{
    [self abstract_hidePickView];
}
- (IBAction)confirmBtnClicked:(UIButton *)sender
{
    // 先把当前的值取到
    NSInteger row = [_xib_pickerView selectedRowInComponent:0];
    if(_currentType == pickerType_type){
        _xib_textField_type.text = _typeArr[row];
    }
    if(_currentType == pickerType_faimily){
        _xib_textField_family.text = [_familyArr[row] objectForKey:@"relation"];
    }
    [self abstract_hidePickView];
}

#pragma mark - UIPickerView datasource 和 delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(_currentType == pickerType_type){
        return _typeArr.count;
    }
    if(_currentType == pickerType_faimily){
        return _familyArr.count;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(_currentType == pickerType_type){
        return _typeArr[row];
    }
    if(_currentType == pickerType_faimily){
        return [_familyArr[row] objectForKey:@"relation"];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(_currentType == pickerType_type){
        _xib_textField_type.text = _typeArr[row];
    }
    if(_currentType == pickerType_faimily){
        _xib_textField_family.text = [_familyArr[row] objectForKey:@"relation"];
    }
}
//- (NSInteger)numberOfRowsInPickerView:(CZPickerView *)pickerView
//{
//    if(pickerView.tag == pickerType_type){
//        return _typeArr.count;
//    }
//    return _familyArr.count;
//}
//- (NSString *)czpickerView:(CZPickerView *)pickerView titleForRow:(NSInteger)row
//{
//    if(pickerView.tag == pickerType_type){
//        return _typeArr[row];
//    }
//    return [_familyArr[row] objectForKey:@"relation"];
//}
//- (void)czpickerView:(CZPickerView *)pickerView
//didConfirmWithItemAtRow:(NSInteger)row
//{
//    [pickerView setHidden:YES];
//    if(pickerView.tag == pickerType_type){
//        _xib_textField_type.text = _typeArr[row];
//    }else{
//        _xib_textField_family.text = [_familyArr[row] objectForKey:@"relation"];
//    }
//}


@end
