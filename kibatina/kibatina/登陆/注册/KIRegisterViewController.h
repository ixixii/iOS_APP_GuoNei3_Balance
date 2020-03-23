//
//  KIRegisterViewController.h
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIRegisterViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_tel;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_password;

- (IBAction)loginBtnClicked:(UIButton *)sender;

- (IBAction)privacyBtnClicked:(UIButton *)sender;

- (IBAction)registerBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
