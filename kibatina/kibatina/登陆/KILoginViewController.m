//
//  KILoginViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KILoginViewController.h"
#import "KIRegisterViewController.h"
#import "KIMessageTool.h"

@interface KILoginViewController ()

@end

@implementation KILoginViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_xib_textField_tel becomeFirstResponder];
}
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
}
- (void)regitsterBtnClicked:(UIButton *)sender
{
    KIRegisterViewController *registerCtrl = [[KIRegisterViewController alloc]init];
    [self presentViewController:registerCtrl animated:YES completion:^{
    }];
}

- (void)loginBtnClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    if(_xib_textField_tel.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入手机号"];
        return;
    }
    if(_xib_textField_password.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入密码"];
        return;
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    // 打个补丁，如果是beyond,123456，那个保存到本地
    if([_xib_textField_tel.text isEqualToString:@"beyond"] && [_xib_textField_password.text isEqualToString:@"123456"]){
        [userDefault setObject:@"beyond" forKey:@"userDefault_tel"];
        [userDefault setObject:@"123456" forKey:@"userDefault_password"];
        [userDefault synchronize];
    }
    
    NSString *tel = [userDefault objectForKey:@"userDefault_tel"];
    NSString *password = [userDefault objectForKey:@"userDefault_password"];
    
    if(![_xib_textField_tel.text isEqualToString:tel] || ![_xib_textField_password.text isEqualToString:password]){
        [KIMessageTool showKIMessage:@"手机号或密码不正确"];
        return;
    }
    [KIMessageTool showKIMessage:@"登陆中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KIMessageTool showKIMessage:@"登陆成功！"];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setBool:YES forKey:@"userDefault_isLogin"];
        [userDefault synchronize];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
}
@end
