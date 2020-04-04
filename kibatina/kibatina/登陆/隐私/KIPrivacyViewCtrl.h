//
//  KIPrivacyViewCtrl.h
//  passwordmanagement
//
//  Created by beyond on 2019/12/22.
//  Copyright © 2019 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIPrivacyViewCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *xib_webView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *xib_indicator;

- (IBAction)closeBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
