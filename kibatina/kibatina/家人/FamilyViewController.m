//
//  FamilyViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/20.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "FamilyViewController.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface FamilyViewController ()

@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
    
    [self pushLoginViewController];
}

- (void)pushLoginViewController
{
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [userDefault boolForKey:@"userDefault_isLogin"];
    if(!isLogin){
        // 弹出登陆控制器
        UIViewController *loginCtrl = [[NSClassFromString(@"KILoginViewController") alloc] init];
        [self.navigationController pushViewController:loginCtrl animated:NO];
    }
}

@end
