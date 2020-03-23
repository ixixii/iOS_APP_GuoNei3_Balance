//
//  KL.m
//  KnowingLife
//
//  Created by xss on 14-12-14.
//  Copyright (c) 2014年 siyan. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>
@implementation UIAlertView(Block)

// 必须手动用运行时绑定方法
- (void)setConfirmBlock:(ConfirmBlock)confirmBlock
{
    objc_setAssociatedObject(self, @selector(confirmBlock), confirmBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (confirmBlock == NULL) {
        self.delegate = nil;
    }
    else {
        self.delegate = self;
    }
}
- (void)setCancelBlock:(ConfirmBlock)cancelBlock
{
    objc_setAssociatedObject(self, @selector(cancelBlock), cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (cancelBlock == NULL) {
        self.delegate = nil;
    }
    else {
        self.delegate = self;
    }
}
- (ConfirmBlock)confirmBlock
{
    return objc_getAssociatedObject(self, @selector(confirmBlock));
}
- (ConfirmBlock)cancelBlock
{
    return objc_getAssociatedObject(self, @selector(cancelBlock));
}



#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // 确定
        if (self.confirmBlock) {
            // self.confirmBlock(self, buttonIndex);
            self.confirmBlock();
        }
    } else {
        // 取消或其他
        // 确定
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
}
@end
