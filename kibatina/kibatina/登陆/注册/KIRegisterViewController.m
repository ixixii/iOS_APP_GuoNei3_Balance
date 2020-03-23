//
//  KIRegisterViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIRegisterViewController.h"
#import "MBProgressHUD+NJ.h"
@interface KIRegisterViewController ()

@end

@implementation KIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)loginBtnClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)privacyBtnClicked:(UIButton *)sender
{
    // 跳转隐私控制器
    // 加载shimo.im 隐私文档
    UIViewController *ctrl = [[NSClassFromString(@"KIPrivacyViewCtrl") alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}
- (void)registerBtnClicked:(UIButton *)sender
{
    // 检查输入
    if(_xib_textField_tel.text.length == 0){
        [MBProgressHUD showError:@"手机号不能为空"];
        return;
    }
    if(_xib_textField_password.text.length == 0){
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
//    [self.view endEditing:YES];
    
    // 保存至本地
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_xib_textField_tel.text forKey:@"userDefault_tel"];
    [userDefault setObject:_xib_textField_password.text forKey:@"userDefault_password"];
    [userDefault synchronize];
    
    [MBProgressHUD showMessage:@"注册中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        
        [MBProgressHUD showSuccess:@"注册成功，请前往登陆"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}
@end
