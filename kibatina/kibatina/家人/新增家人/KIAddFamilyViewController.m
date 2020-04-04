//
//  KIAddFamilyViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/24.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIAddFamilyViewController.h"
#import "KIMessageTool.h"

@interface KIAddFamilyViewController ()

@end

@implementation KIAddFamilyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加家人";
    // 返回按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)addFamilyBtnClicked:(UIButton *)sender
{
    if(_xib_textField_relation.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入家人关系"];
        return;
    }
    if(_xib_textField_habit.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入消费习惯"];
        return;
    }
    if(_xib_textField_interest.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入消费热点"];
        return;
    }
    if(_xib_textField_desc.text.length == 0){
        [KIMessageTool showKIMessage:@"请输入家人描述"];
        return;
    }
    // 存入本地plist
    // 根据用户上次选择的,展示
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *familyArr = [userDefault objectForKey:@"userDefault_familyArr"];
//    if(!familyArr){
//        familyArr = [NSMutableArray array];
//    }
    NSDictionary *newFamily = @{
        @"relation": _xib_textField_relation.text,
        @"habit": _xib_textField_habit.text,
        @"interest": _xib_textField_interest.text,
        @"desc": _xib_textField_desc.text
    };
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:familyArr];
    [mArr addObject:newFamily];
    [userDefault setObject:mArr forKey:@"userDefault_familyArr"];
    [userDefault synchronize];
    
    [KIMessageTool showKIMessage:@"提交中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KIMessageTool showKIMessage:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}
@end
