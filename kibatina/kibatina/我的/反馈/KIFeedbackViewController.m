//
//  KIFeedbackViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIFeedbackViewController.h"
#import "MBProgressHUD+NJ.h"

@interface KIFeedbackViewController ()<UITextViewDelegate>

@end

@implementation KIFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"反馈";
    // 返回按钮文字(返回时，要设置回原来的)
//    self.navigationController.navigationBar.topItem.title = @"";
    
    // 返回按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.topItem.title = @"我的";
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入您的意见和建议"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入您的意见和建议";
        textView.textColor = [UIColor lightGrayColor];
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger leftCount = 500 - textView.text.length;
    self.xib_countLabel.text = [NSString stringWithFormat:@"最多输入%ld字",leftCount];
    if(leftCount > 0){
        self.xib_countLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.xib_countLabel.textColor = [UIColor redColor];
    }
}

- (IBAction)sendBtnClicked:(UIButton *)sender
{
    if(self.xib_textView.text.length > 0 && ![self.xib_textView.text isEqualToString:@"请输入您的意见和建议"]){
        [self.view endEditing:YES];
        [MBProgressHUD showMessage:@"提交中。。。"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"提交成功！"];
            __weak __typeof__(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.view endEditing:YES];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
            
        });
        
    }else{
        [MBProgressHUD showError:@"请输入内容后再提交"];
    }
}

@end
