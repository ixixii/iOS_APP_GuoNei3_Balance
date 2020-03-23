//
//  MineViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "MineViewController.h"
#import "KITableViewCell.h"
#import "KIHeadView.h"
#import "MBProgressHUD+NJ.h"
#import "UIAlertView+Block.h"
#import "KILoginViewController.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_modelArr;
}
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(_modelArr.count == 3){
        [_modelArr addObject:@{
            @"icon": @"logout.png",
            @"title": @"退出登陆",
            @"className": @"LogoutViewController"
        }];
        [_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetTabBarItemTextColor];
    
    [self addTableView];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.title = @"我的";
//}

- (void)resetTabBarItemTextColor
{
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
}

- (void)addTableView
{
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView = tableView;
    
    // 数据源
    NSArray *tmpArr = @[
//        @{
//            @"icon": @"message.png", // 90px -> @3x
//            @"title": @"我的消息",
//            @"className": @"MessageViewController"
//        },
//        @{
//            @"icon": @"remind.png", // 90px -> @3x
//            @"title": @"我的提醒",
//            @"className": @"RemindViewController"
//        },
        @{
            @"icon": @"kefu.png", // 90px -> @3x
            @"title": @"客服电话",
            @"detailText": @"+86 16675565267"
        },
        @{
            @"icon": @"feedback.png",
            @"title": @"意见反馈",
            @"className": @"KIFeedbackViewController"
        },
//        @{
//            @"icon": @"cache.png",
//            @"title": @"清除缓存"
//        },
        @{
            @"icon": @"about.png",
            @"title": @"关于我们",
            @"className": @"KIAboutViewController"
        },
        @{
            @"icon": @"logout.png",
            @"title": @"退出登陆",
            @"className": @"LogoutViewController"
        }
    ];
    _modelArr = [NSMutableArray arrayWithArray:tmpArr];
    
    // tableView的head
    _tableView.tableHeaderView = [KIHeadView headView];
//    _tableView.backgroundColor = kColor(253, 176, 72);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kitableviewcellid"];
    if (cell == nil) {
        cell = [KITableViewCell tableViewCell];
    }
    cell.textLabel.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary *model = [_modelArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[model objectForKey:@"icon"]];
    cell.textLabel.text = [model objectForKey:@"title"];
    cell.detailTextLabel.text = [model objectForKey:@"detailText"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            {
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"16675565267"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
            break;
        case 1:
            {
                NSString *className = [[_modelArr objectAtIndex:indexPath.row] objectForKey:@"className"];
                UIViewController *ctrl = [[NSClassFromString(className) alloc]init];
                [self.navigationController pushViewController:ctrl animated:YES];
            }
            break;
        case 2:
            {
                NSString *className = [[_modelArr objectAtIndex:indexPath.row] objectForKey:@"className"];
                UIViewController *ctrl = [[NSClassFromString(className) alloc]init];
                [self.navigationController pushViewController:ctrl animated:YES];
            }
            break;
        case 3:
            {
                // 退出登陆
                // 删除场景 要给提示
                UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登陆？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [MBProgressHUD showMessage:@"请求中..."];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showSuccess:@"退出成功"];
                        // 清除登陆状态
                        // 根据用户上次选择的,展示
                        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                        [userDefault setBool:NO forKey:@"userDefault_isLogin"];
                        [userDefault synchronize];
                        
                        // 弹出登陆控制器
                        KILoginViewController *loginCtrl = [[KILoginViewController alloc] init];
                        
                        [self.navigationController pushViewController:loginCtrl animated:YES];
                        
                        if(_modelArr.count == 4){
                            // modelArr 将最后一个移除
                            [_modelArr removeLastObject];
                            [_tableView reloadData];
                        }
                    });
                    
                }];
                
                [alertCtrl addAction:cancelAction];
                [alertCtrl addAction:confirmAction];
                
                [self presentViewController:alertCtrl animated:YES completion:nil];
            }
            break;
            
        default:
            break;
    }
}
@end
