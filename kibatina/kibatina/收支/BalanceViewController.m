//
//  BalanceViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/20.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "BalanceViewController.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface BalanceViewController ()

@end

@implementation BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
}


@end
