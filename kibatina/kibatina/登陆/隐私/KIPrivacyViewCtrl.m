//
//  KIPrivacyViewCtrl.m
//  passwordmanagement
//
//  Created by beyond on 2019/12/22.
//  Copyright © 2019 beyond. All rights reserved.
//

#import "KIPrivacyViewCtrl.h"

@interface KIPrivacyViewCtrl ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *xib_webView;

- (IBAction)closeBtnClicked:(UIButton *)sender;

@end

@implementation KIPrivacyViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://shimo.im/docs/9VkCcCcVXtgGvDcT/read"];
    [self.xib_webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0]];
    self.xib_webView.delegate = self;
    
    [self.xib_indicator startAnimating];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.xib_indicator removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
