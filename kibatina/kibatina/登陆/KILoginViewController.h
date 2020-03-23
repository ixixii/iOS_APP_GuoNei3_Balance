//
//  KILoginViewController.h
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KILoginViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_tel;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_password;

- (IBAction)regitsterBtnClicked:(UIButton *)sender;
- (IBAction)loginBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
