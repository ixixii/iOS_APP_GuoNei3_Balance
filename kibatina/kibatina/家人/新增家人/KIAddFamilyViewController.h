//
//  KIAddFamilyViewController.h
//  kibatina
//
//  Created by beyond on 2020/03/24.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIAddFamilyViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_relation;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_habit;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_interest;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_desc;

- (IBAction)addFamilyBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
