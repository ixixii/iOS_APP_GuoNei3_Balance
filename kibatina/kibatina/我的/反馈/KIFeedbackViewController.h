//
//  KIFeedbackViewController.h
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIFeedbackViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextView *xib_textView;
@property (nonatomic,weak) IBOutlet UILabel *xib_countLabel;
- (IBAction)sendBtnClicked:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
