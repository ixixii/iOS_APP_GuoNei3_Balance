//
//  KIMessageTool.h
//  kibatina
//
//  Created by beyond on 2020/04/03.
//  Copyright © 2020 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface KIMessageTool : NSObject
+(void)showKIMessage:(NSString *)message;
+(void)showKIMessage:(NSString *)message duration:(NSInteger)duration;
+(void)showKIMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY;
@end

NS_ASSUME_NONNULL_END
