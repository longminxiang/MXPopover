//
//  MXPopover.h
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 Eric Lung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXAnimation.h"
#import "MXPopoverBackground.h"

@interface MXPopover : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, assign) MXPopoverBackgroundType backgroundType;

@property (nonatomic, assign) BOOL enableTouchedDismiss;

@property (nonatomic, assign) MXAnimationInType showAnimation;

@property (nonatomic, assign) MXAnimationOutType dismissAnimation;

@end

@interface UIView (MXPopover)

- (void)showPopoverWithView:(UIView *)targetView;

- (void)showPopoverWithView:(UIView *)targetView popover:(void (^)(MXPopover *popover))block;

- (void)dismissPopover;

@end
