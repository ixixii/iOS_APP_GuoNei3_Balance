//
//  KIAboutViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIAboutViewController.h"

@interface KIAboutViewController ()

@end

@implementation KIAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"关于我们";
    
//    self.navigationController.navigationBar.topItem.title = @"";
    
    // 返回按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//- (void)willMoveToParentViewController:(UIViewController *)parent
//{
//    [super willMoveToParentViewController:parent];
//    UIViewController *ctrl = [self.navigationController.viewControllers objectAtIndex:0];
////    ctrl.title = @"我的";
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
