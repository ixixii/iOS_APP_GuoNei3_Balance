//
//  KIAddBalanceViewController.h
//  kibatina
//
//  Created by beyond on 2020/03/25.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIAddBalanceViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_amount;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_type;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_family;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_date;
- (IBAction)btnTypeClicked:(UIButton *)sender;
- (IBAction)btnFamilyClicked:(UIButton *)sender;
- (IBAction)btnDateClicked:(UIButton *)sender;

@property (nonatomic,weak) IBOutlet UITextField *xib_textField_name;
@property (nonatomic,weak) IBOutlet UITextField *xib_textField_remark;
- (IBAction)addBtnClicked:(UIButton *)sender;

@property (nonatomic,strong) NSDictionary *model;

@property (nonatomic,weak) IBOutlet UIButton *xib_button_add;
@property (nonatomic,weak) IBOutlet UIButton *xib_button_type;
@property (nonatomic,weak) IBOutlet UIButton *xib_button_family;
@property (nonatomic,weak) IBOutlet UIButton *xib_button_date;

@property (nonatomic,weak) IBOutlet UIImageView *xib_imageView_1;
@property (nonatomic,weak) IBOutlet UIImageView *xib_imageView_2;
@property (nonatomic,weak) IBOutlet UIImageView *xib_imageView_3;
@end

NS_ASSUME_NONNULL_END
