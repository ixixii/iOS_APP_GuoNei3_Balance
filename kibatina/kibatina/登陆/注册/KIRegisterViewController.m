//
//  KIRegisterViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIRegisterViewController.h"
#import "KIMessageTool.h"
@interface KIRegisterViewController ()

@end

@implementation KIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_xib_textField_tel becomeFirstResponder];
}
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
    [self.view endEditing:YES];
    // 检查输入
    if(_xib_textField_tel.text.length == 0){
        [KIMessageTool showKIMessage:@"手机号不能为空"];
        return;
    }
    if(_xib_textField_password.text.length == 0){
        [KIMessageTool showKIMessage:@"密码不能为空"];
        return;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_xib_textField_tel.text forKey:@"userDefault_tel"];
    [userDefault setObject:_xib_textField_password.text forKey:@"userDefault_password"];
    [userDefault synchronize];
    [KIMessageTool showKIMessage:@"注册中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KIMessageTool showKIMessage:@"注册成功，请前往登陆"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}
@end
