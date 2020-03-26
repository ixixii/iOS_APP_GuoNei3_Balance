//
//  KIFamilyTableViewCell.h
//  kibatina
//
//  Created by beyond on 2020/03/24.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KIFamilyTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *xib_label_relation;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_habit;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_interest;
@property (nonatomic,weak) IBOutlet UILabel *xib_label_desc;

@property (nonatomic,weak) IBOutlet UIButton *xib_btn_del;
+ (instancetype)tableViewCell;
@end

NS_ASSUME_NONNULL_END
