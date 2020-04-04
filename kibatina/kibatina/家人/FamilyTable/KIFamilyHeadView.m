//
//  KIFamilyHeadView.m
//  kibatina
//
//  Created by beyond on 2020/03/24.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIFamilyHeadView.h"

@implementation KIFamilyHeadView

+ (instancetype)headView
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:@"KIFamilyHeadView" owner:nil options:nil];
    return tmpArr[0];
}
@end
