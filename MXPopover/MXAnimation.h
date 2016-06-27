//
//  MXAnimation.h
//  WuYe
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MXAnimationInType) {
    MXAnimationFadeIn = 0,
    MXAnimationSlideInLeftTop,
    MXAnimationSlideInLeftCenter,
    MXAnimationSlideInLeftBottom,
    MXAnimationSlideInRightTop,
    MXAnimationSlideInRightCenter,
    MXAnimationSlideInRightBottom,
    MXAnimationSlideInTopTop,
    MXAnimationSlideInTopCenter,
    MXAnimationSlideInTopBottom,
    MXAnimationSlideInBottomTop,
    MXAnimationSlideInBottomCenter,
    MXAnimationSlideInBottomBottom,
};

typedef NS_ENUM(NSUInteger, MXAnimationOutType) {
    MXAnimationFadeOut = 0,
    MXAnimationSlideOutLeft,
    MXAnimationSlideOutRight,
    MXAnimationSlideOutTop,
    MXAnimationSlideOutBottom,
};

@interface MXAnimation : NSObject

+ (void)animatedView:(UIView *)view
              inType:(MXAnimationInType)inAnimation
          inDuration:(CGFloat)inDuration
             inDelay:(CGFloat)inDelay
      extraAnimation:(void (^)())extraAnimation
          completion:(void (^)())completion;

+ (void)animatedView:(UIView *)view
                 out:(MXAnimationOutType)inAnimation
         outDuration:(CGFloat)outDuration
            outDelay:(CGFloat)outDelay
      extraAnimation:(void (^)())extraAnimation
          completion:(void (^)())completion;

@end