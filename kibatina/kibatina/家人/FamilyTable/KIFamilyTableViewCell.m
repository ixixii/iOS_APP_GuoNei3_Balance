//
//  KIFamilyTableViewCell.m
//  kibatina
//
//  Created by beyond on 2020/03/24.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIFamilyTableViewCell.h"

@implementation KIFamilyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)tableViewCell
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return tmpArr[0];
}
@end
