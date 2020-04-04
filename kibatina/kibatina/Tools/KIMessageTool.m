//
//  KIMessageTool.m
//  kibatina
//
//  Created by beyond on 2020/04/03.
//  Copyright © 2020 beyond. All rights reserved.
//

#import "KIMessageTool.h"

#define ki_ScreenBounds [UIScreen mainScreen].bounds
#define ki_ScreenWidth ki_ScreenBounds.size.width
#define ki_ScreenHeight ki_ScreenBounds.size.height

typedef NS_ENUM(NSInteger, KIMessagePositionY){
  KIMessagePositionY_top = 0,
  KIMessagePositionY_center,
  KIMessagePositionY_bottom
};

@implementation KIMessageTool
+(void)showKIMessage:(NSString *)message
{
    [KIMessageTool showKIMessage:message duration:3];
}
+(void)showKIMessage:(NSString *)message duration:(NSInteger)duration
{
    [KIMessageTool showKIMessage:message duration:duration positionY:KIMessagePositionY_center];
}
+(void)showKIMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY
{
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(ki_ScreenWidth, 9999)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    [showview addSubview:label];
    NSInteger messageY = 0;
    switch (positionY) {
        case KIMessagePositionY_top:
            {
                messageY = 100;
            }
            break;
        case KIMessagePositionY_center:
        {
            messageY = ki_ScreenHeight/2 - LabelSize.height/2;
        }
            break;
        case KIMessagePositionY_bottom:
        {
            messageY = ki_ScreenHeight - 100;
        }
            break;
            
        default:
            break;
    }
    
    showview.frame = CGRectMake((ki_ScreenWidth - LabelSize.width - 20)/2, messageY, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:duration animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}
@end
