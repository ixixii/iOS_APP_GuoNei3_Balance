//
//  KITextField.m
//  kibatina
//
//  Created by beyond on 2020/03/23.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KITextField.h"

@implementation KITextField

// 设置leftViewk时，才会执行此方法
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}
//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, 45, 0);
}
@end
