//
//  KILoginViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KILoginViewController.h"
#import "KIRegisterViewController.h"
#import "MBProgressHUD+NJ.h"

@interface KILoginViewController ()

@end

@implementation KILoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 隐藏 导航栏
//    self.navigationController.navigationBar
}
- (void)regitsterBtnClicked:(UIButton *)sender
{
    KIRegisterViewController *registerCtrl = [[KIRegisterViewController alloc]init];
    [self presentViewController:registerCtrl animated:YES completion:^{
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loginBtnClicked:(UIButton *)sender
{
    if(_xib_textField_tel.text.length == 0){
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    if(_xib_textField_password.text.length == 0){
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    
//    [self.view endEditing:YES];
    
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *tel = [userDefault objectForKey:@"userDefault_tel"];
    NSString *password = [userDefault objectForKey:@"userDefault_password"];
    
    if(![_xib_textField_tel.text isEqualToString:tel] || ![_xib_textField_password.text isEqualToString:password]){
        [MBProgressHUD showError:@"手机号或密码不正确"];
        return;
    }
    
    [MBProgressHUD showMessage:@"登陆中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"登陆成功！"];
        
        // 设置登陆状态
        // 根据用户上次选择的,展示
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setBool:YES forKey:@"userDefault_isLogin"];
        [userDefault synchronize];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
    
    
}
@end
