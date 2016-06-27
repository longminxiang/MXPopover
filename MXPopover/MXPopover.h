//
//  MXPopover.h
//  WuYe
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXAnimation.h"
#import "MXPopoverBackground.h"

@interface MXPopover : NSObject

+ (void)setDisMissType:(MXAnimationOutType)disMissType;

+ (void)setTouchedDismissEnable:(BOOL)enable;

+ (void)setBackgroundType:(MXPopoverBackgroundType)backgroundType;

+ (void)popView:(UIView *)view inView:(UIView *)inView animationType:(MXAnimationInType)type completion:(void (^)(void))completion;

+ (void)popView:(UIView *)view animationType:(MXAnimationInType)type completion:(void (^)(void))completion;

+ (void)dismissWithType:(MXAnimationOutType)type completion:(void (^)(void))completion;

+ (void)dismiss:(void (^)(void))completion;

@end