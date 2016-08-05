//
//  MXAnimation.m
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 Eric Lung. All rights reserved.
//

#import "MXAnimation.h"

@interface MXAnimation ()

@end

@implementation MXAnimation

+ (void)animatedView:(UIView *)view inType:(MXAnimationInType)inAnimation inDuration:(CGFloat)inDuration inDelay:(CGFloat)inDelay extraAnimation:(void (^)())extraAnimation completion:(void (^)())completion
{
    UIView *superView = view.superview;
    CGRect superViewBounds = superView.bounds;
    
    CGRect prepareFrame = view.frame;
    
    BOOL isDefault = NO;
    
    switch (inAnimation) {
        case MXAnimationSlideInLeftTop: {
            prepareFrame.origin.x = -prepareFrame.size.width;
            prepareFrame.origin.y = 0;
            break;
        }
        case MXAnimationSlideInLeftCenter: {
            prepareFrame.origin.x = -prepareFrame.size.width;
            prepareFrame.origin.y = (superViewBounds.size.height - prepareFrame.size.height) / 2;
            break;
        }
        case MXAnimationSlideInLeftBottom: {
            prepareFrame.origin.x = -prepareFrame.size.width;
            prepareFrame.origin.y = superViewBounds.size.height - prepareFrame.size.height;
            break;
        }
        case MXAnimationSlideInRightTop: {
            prepareFrame.origin.x = superViewBounds.size.width;
            prepareFrame.origin.y = 0;
            break;
        }
        case MXAnimationSlideInRightCenter: {
            prepareFrame.origin.x = superViewBounds.size.width;
            prepareFrame.origin.y = (superViewBounds.size.height - prepareFrame.size.height) / 2;
            break;
        }
        case MXAnimationSlideInRightBottom: {
            prepareFrame.origin.x = superViewBounds.size.width;
            prepareFrame.origin.y = superViewBounds.size.height - prepareFrame.size.height;
            break;
        }
        case MXAnimationSlideInTopTop:
        case MXAnimationSlideInTopCenter:
        case MXAnimationSlideInTopBottom: {
            prepareFrame.origin.x = (superViewBounds.size.width - prepareFrame.size.width) / 2;;
            prepareFrame.origin.y = -prepareFrame.size.height;
            break;
        }
        case MXAnimationSlideInBottomTop:
        case MXAnimationSlideInBottomCenter:
        case MXAnimationSlideInBottomBottom: {
            prepareFrame.origin.x = (superViewBounds.size.width - prepareFrame.size.width) / 2;;
            prepareFrame.origin.y = superViewBounds.size.height;
            break;
        }
        default:
            isDefault = YES;
            break;
    }
    if (isDefault) view.alpha = 0;
    else view.frame = prepareFrame;
    
    switch (inAnimation) {
        case MXAnimationSlideInLeftTop:
        case MXAnimationSlideInLeftCenter:
        case MXAnimationSlideInLeftBottom:
        case MXAnimationSlideInRightTop:
        case MXAnimationSlideInRightCenter:
        case MXAnimationSlideInRightBottom:
            prepareFrame.origin.x = (superViewBounds.size.width - prepareFrame.size.width) / 2;
            break;
        case MXAnimationSlideInTopTop:
        case MXAnimationSlideInBottomTop:
            prepareFrame.origin.y = 0;
            break;
        case MXAnimationSlideInTopCenter:
        case MXAnimationSlideInBottomCenter:
            prepareFrame.origin.y = (superViewBounds.size.height - prepareFrame.size.height) / 2;
            break;
        case MXAnimationSlideInTopBottom:
        case MXAnimationSlideInBottomBottom:
            prepareFrame.origin.y = superViewBounds.size.height - prepareFrame.size.height;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:inDuration delay:inDelay usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        if (isDefault) view.alpha = 1;
        else view.frame = prepareFrame;
        if (extraAnimation) extraAnimation();
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

+ (void)animatedView:(UIView *)view out:(MXAnimationOutType)inAnimation outDuration:(CGFloat)outDuration outDelay:(CGFloat)outDelay extraAnimation:(void (^)())extraAnimation completion:(void (^)())completion
{
    UIView *superView = view.superview;
    CGRect superViewBounds = superView.bounds;
    CGRect animatedFrame = CGRectZero;
    BOOL isDefault = NO;
    switch (inAnimation) {
        case MXAnimationSlideOutLeft: {
            CGRect bframe = view.frame;
            bframe.origin.x = -bframe.size.width;
            bframe.origin.y = (superViewBounds.size.height - bframe.size.height) / 2;
            animatedFrame = bframe;
            break;
        }
        case MXAnimationSlideOutRight: {
            CGRect bframe = view.frame;
            bframe.origin.x = superViewBounds.size.width;
            bframe.origin.y = (superViewBounds.size.height - bframe.size.height) / 2;
            animatedFrame = bframe;
            break;
        }
        case MXAnimationSlideOutTop: {
            CGRect bframe = view.frame;
            bframe.origin.x = (superViewBounds.size.width - bframe.size.width) / 2;
            bframe.origin.y = -bframe.size.height;
            animatedFrame = bframe;
            break;
        }
        case MXAnimationSlideOutBottom: {
            CGRect bframe = view.frame;
            bframe.origin.x = (superViewBounds.size.width - bframe.size.width) / 2;
            bframe.origin.y = superViewBounds.size.height;
            animatedFrame = bframe;
            break;
        }
        default:
            isDefault = YES;
            break;
    }
    [UIView animateWithDuration:outDuration delay:outDelay usingSpringWithDamping:0.8 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        if (isDefault) view.alpha = 0;
        else view.frame = animatedFrame;
        if (extraAnimation) extraAnimation();
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

@end
