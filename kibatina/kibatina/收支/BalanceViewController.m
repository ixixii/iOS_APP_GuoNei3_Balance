//
//  BalanceViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/20.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "BalanceViewController.h"
#import "KIFamilyHeadView.h"
#import "KIBalanceTableViewCell.h"
#import "KIAddBalanceViewController.h"


#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height

@interface BalanceViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_balanceArr;
}
@end

@implementation BalanceViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tab bar text 高亮时，文字颜色
    NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:kColor(253, 176, 72), UITextAttributeTextColor, nil];
    [self.xib_tabBarItem setTitleTextAttributes:tmpDict forState:UIControlStateHighlighted];
    
    [self loadData];
    
    [self addSubViews];
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
    KIFamilyHeadView *headView = [KIFamilyHeadView headView];
    headView.xib_imgView_banner.image = [UIImage imageNamed:@"balance_banner4.png"];
    _tableView.tableHeaderView = headView;
    _tableView.showsVerticalScrollIndicator = NO;
}
- (void)loadData
{
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *arr = [userDefault objectForKey:@"userDefault_balanceArr"];
    _balanceArr = [NSMutableArray arrayWithArray:arr];
    if(_tableView){
        [_tableView reloadData];
    }
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _balanceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KIBalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kibalancetableviewcellid"];
    if (cell == nil) {
        cell = [KIBalanceTableViewCell tableViewCell];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        [cell.xib_btn_del addTarget:self action:@selector(delBtnClickedFunc:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSDictionary *balanceDict = [_balanceArr objectAtIndex:indexPath.row];
    cell.xib_label_name.text = [NSString stringWithFormat:@"收支名称：%@",balanceDict[@"name"]];
    cell.xib_label_type.text = [NSString stringWithFormat:@"收支分类：%@",balanceDict[@"type"]];
    cell.xib_label_amount.text = [NSString stringWithFormat:@"收支金额：%@",balanceDict[@"amount"]];
    cell.xib_label_date.text = [NSString stringWithFormat:@"收支日期：%@",balanceDict[@"date"]];
    cell.xib_label_family.text = [NSString stringWithFormat:@"所属家人：%@",balanceDict[@"family"]];
    cell.xib_label_remark.text = [NSString stringWithFormat:@"备注描述：%@",balanceDict[@"remark"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 216;
}
#pragma mark - btn 事件
- (void)addBtnClicked:(UIButton *)sender
{
    KIAddBalanceViewController *addCtrl = [[KIAddBalanceViewController alloc]init];
    [self.navigationController pushViewController:addCtrl animated:YES];
}

- (void)delBtnClickedFunc:(UIButton *)btn
{
    // 弹出确认提示框
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认删除该收支记录？" preferredStyle:UIAlertControllerStyleAlert];
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
    while (![btn isMemberOfClass:[KIBalanceTableViewCell class]]){
        btn = (UIButton *)[btn superview];
    }
    KIBalanceTableViewCell *cell = (KIBalanceTableViewCell *)btn;
    UITableView *tableView = (UITableView *)cell;
    while (![tableView isMemberOfClass:[UITableView class]]){
        tableView = (UITableView *)[tableView superview];
    }
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    NSLog(@"sg_%ld",indexPath.row);
    // ----------------------
    // 删除数据源(待优化)，更新数据到本地，重载tableView,
    [_balanceArr removeObjectAtIndex:indexPath.row];
    [self abstract_saveData];
    [_tableView reloadData];
}
- (void)abstract_saveData
{
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:_balanceArr forKey:@"userDefault_balanceArr"];
    [userDefault synchronize];
}
#pragma mark - tableView 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *currentBalance = _balanceArr[indexPath.row];
    KIAddBalanceViewController *addCtrl = [[KIAddBalanceViewController alloc]init];
    addCtrl.model = currentBalance;
    [self.navigationController pushViewController:addCtrl animated:YES];
}
@end
