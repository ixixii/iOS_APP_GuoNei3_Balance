//
//  UIAlertView+Block.h
//  KnowingLife
//
//  Created by xss on 14-12-14.
//  Copyright (c) 2014年 siyan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UIAlertViewBlock)(UIAlertView *alertView, NSInteger buttonIndex);
typedef void (^ConfirmBlock)(void);
@interface UIAlertView(Block) <UIAlertViewDelegate>
@property (nonatomic,copy)ConfirmBlock confirmBlock;
@property (nonatomic,copy)ConfirmBlock cancelBlock;
// 必须手动用运行时绑定方法
- (void)setConfirmBlock:(ConfirmBlock)confirmBlock;
- (void)setCancelBlock:(ConfirmBlock)cancelBlock;
- (ConfirmBlock)cancelBlock;
- (ConfirmBlock)confirmBlock;
@end
