//
//  MyNavigationController.m
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "MyNavigationController.h"
#import "UIImage+Color.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface MyNavigationController ()

@end

@implementation MyNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kColor(253, 176, 72)] forBarMetrics:(UIBarMetricsDefault)];
    
    [self.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
      NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 首页不需要隐藏tabbar
    NSString *ctrlName = NSStringFromClass([viewController class]);
    
    if ([ctrlName isEqualToString:@"MineViewController"] ) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
       // 其他push时需要隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
