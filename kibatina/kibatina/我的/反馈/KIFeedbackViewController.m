//
//  KIFeedbackViewController.m
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIFeedbackViewController.h"
#import "KIMessageTool.h"

@interface KIFeedbackViewController ()<UITextViewDelegate>

@end

@implementation KIFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"请输入您的意见和建议"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"请输入您的意见和建议";
        textView.textColor = [UIColor lightGrayColor];
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger leftCount = 500 - textView.text.length;
    self.xib_countLabel.text = [NSString stringWithFormat:@"最多输入%ld字",leftCount];
    if(leftCount > 0){
        self.xib_countLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.xib_countLabel.textColor = [UIColor redColor];
    }
}
- (IBAction)sendBtnClicked:(UIButton *)sender
{
    if(self.xib_textView.text.length > 0 && ![self.xib_textView.text isEqualToString:@"请输入您的意见和建议"]){
        [self.view endEditing:YES];
        [KIMessageTool showKIMessage:@"提交中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KIMessageTool showKIMessage:@"提交成功!"];
            __weak __typeof__(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.view endEditing:YES];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        });
    }else{
        [KIMessageTool showKIMessage:@"请输入内容后再提交"];
    }
}

@end
