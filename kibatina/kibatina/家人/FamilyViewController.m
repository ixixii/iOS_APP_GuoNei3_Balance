//
//  FamilyViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/20.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "FamilyViewController.h"
#import "KIFamilyTableViewCell.h"
#import "KIFamilyHeadView.h"
#import "KIAddFamilyViewController.h"
#import "SomeoneBalanceViewController.h"

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height

@interface FamilyViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSMutableArray *_familyArr;
}
@end

@implementation FamilyViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
    
    [self pushLoginViewController];
    
    [self loadData];
    
    [self addSubViews];
}
- (void)loadData
{
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *tmpArr = [userDefault objectForKey:@"userDefault_familyArr"];
    _familyArr = [NSMutableArray arrayWithArray:tmpArr];
    
    if(!tmpArr){
        // 如果是第一次启动，创建几个初始家人
        NSArray *initFamilyArr = @[
            @{
                @"relation": @"我",
                @"habit": @"大手大脚",
                @"interest": @"羊肉米线、桂林卤粉",
                @"desc": @"IT民工、二次元宅男"
            }
        ];
        _familyArr = [NSMutableArray arrayWithArray:initFamilyArr];
        [userDefault setObject:_familyArr forKey:@"userDefault_familyArr"];
        
        // 如果是第一次启动，创建几个初始收支
        NSArray *initBalanceArr = @[
            @{
                @"name": @"工资",
                @"type": @"收入",
                @"amount": @"20489.08",
                @"date": @"2020-03-13 14:12",
                @"family": @"我",
                @"remark": @"中国银行工资卡(税后)"
            }
        ];
        [userDefault setObject:initBalanceArr forKey:@"userDefault_balanceArr"];
        [userDefault synchronize];
    }
    if(_tableView){
        [_tableView reloadData];
    }
}
- (void)addSubViews
{
    [self addBgView];
    [self addTableView];
}

- (void)addBgView
{
    CGRect rect = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 44);
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:rect];
    bgView.image = [UIImage imageNamed:@"background.png"];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgView];
}
- (void)addTableView
{
    CGRect frame = CGRectMake(20, 64, ScreenWidth-40, ScreenHeight - 64);
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _tableView = tableView;
    _tableView.tableHeaderView = [KIFamilyHeadView headView];
    
    _tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _familyArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kifamilytableviewcellid"];
    if (cell == nil) {
        cell = [KIFamilyTableViewCell tableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_btn_del addTarget:self action:@selector(delBtnClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *familyDict = [_familyArr objectAtIndex:indexPath.row];
    cell.xib_label_relation.text = [NSString stringWithFormat:@"家人关系：%@",familyDict[@"relation"]];
    cell.xib_label_habit.text = [NSString stringWithFormat:@"消费习惯：%@",familyDict[@"habit"]];
    cell.xib_label_interest.text = [NSString stringWithFormat:@"消费热点：%@",familyDict[@"interest"]];
    cell.xib_label_desc.text = [NSString stringWithFormat:@"家人描述：%@",familyDict[@"desc"]];
    return cell;
}
- (void)delBtnClickedFunc:(UIButton *)btn
{
    // 弹出确认提示框
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该家人，所属收支也会随之删除？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self delBtnClicked:btn];
    }];
    [alertCtrl addAction:cancelAction];
    [alertCtrl addAction:confirmAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
- (void)delBtnClicked:(UIButton *)btn
{
    // 从btn获取到indexPath.row
    while (![btn isMemberOfClass:[KIFamilyTableViewCell class]]){
        btn = (UIButton *)[btn superview];
    }
    KIFamilyTableViewCell *cell = (KIFamilyTableViewCell *)btn;
    UITableView *tableView = (UITableView *)cell;
    while (![tableView isMemberOfClass:[UITableView class]]){
        tableView = (UITableView *)[tableView superview];
    }
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    NSLog(@"sg_%ld",indexPath.row);
    // ----------------------
    NSDictionary *currentFamilyDict = [_familyArr objectAtIndex:indexPath.row];
    NSString *tmpRelation = currentFamilyDict[@"relation"];
    // 删除数据源(待优化)，更新数据到本地，重载tableView,
    [_familyArr removeObjectAtIndex:indexPath.row];
    
    // 删除balanceArr中，所有family为familyDict[@"relation"]的dict
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *tmpBalanceArr = [userDefault objectForKey:@"userDefault_balanceArr"];
    NSMutableArray *resultBalanceArr = [NSMutableArray array];
    for (NSDictionary *tmpBalanceDict in tmpBalanceArr) {
        if(![tmpBalanceDict[@"family"] isEqualToString:tmpRelation]){
            [resultBalanceArr addObject:tmpBalanceDict];
        }
    }
    [userDefault setObject:resultBalanceArr forKey:@"userDefault_balanceArr"];
    
    [self abstract_saveFamilyData];
    [_tableView reloadData];
}
- (void)abstract_saveFamilyData
{
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_familyArr forKey:@"userDefault_familyArr"];
    [userDefault synchronize];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
#pragma mark - btn 事件
- (void)addBtnClicked:(UIButton *)sender
{
    KIAddFamilyViewController *addCtrl = [[KIAddFamilyViewController alloc]init];
    [self.navigationController pushViewController:addCtrl animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *familyDict = _familyArr[indexPath.row];
    SomeoneBalanceViewController *ctrl = [[SomeoneBalanceViewController alloc] init];
    ctrl.familyDict = familyDict;
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
