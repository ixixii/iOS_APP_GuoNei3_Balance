//
//  KIBalanceTableViewCell.h
//  kibatina
//
//  Created by beyond on 2020/03/25.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIBalanceTableViewCell : UITableViewCell
+ (instancetype)tableViewCell;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_name;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_type;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_amount;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_date;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_family;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_remark;
@property (nonatomic,weak) IBOutlet UIButton *xib_btn_del;
@end

NS_ASSUME_NONNULL_END
