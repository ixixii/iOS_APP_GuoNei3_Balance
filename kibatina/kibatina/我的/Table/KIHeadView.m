//
//  KIHeadView.m
//  kibatina
//
//  Created by beyond on 2020/03/22.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIHeadView.h"

@implementation KIHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headView
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:@"KIHeadView" owner:nil options:nil];
    return tmpArr[0];
}

@end
