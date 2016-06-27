//
//  MXPopover.m
//  WuYe
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 ss. All rights reserved.
//

#import "MXPopover.h"

#pragma mark === MXContainView ===

@interface MXContainView : UIView

typedef void (^MXContainViewTouchedBlock)(MXContainView *mview, UITouch *touch);

@property (nonatomic, readonly) MXPopoverBackgroundView *backgroundView;

@end

@implementation MXContainView
@synthesize backgroundView = _backgroundView;

- (MXPopoverBackgroundView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [MXPopoverBackgroundView new];
        _backgroundView.type = MXPopoverBackgroundTypeBlur;
        [self insertSubview:_backgroundView atIndex:0];
    }
    return _backgroundView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.backgroundView.frame = self.bounds;
}

- (BOOL)resignFirstResponder
{
    [self.subviews makeObjectsPerformSelector:@selector(resignFirstResponder)];
    return [super resignFirstResponder];
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", [[self class] description]);
}

@end

#pragma mark === MXPopver ===

@interface MXPopover ()

@property (nonatomic, readonly) MXContainView *containView;

@property (nonatomic, assign) BOOL enableTouchedDismiss;
@property (nonatomic, assign) MXAnimationOutType disMissType;
@property (nonatomic, assign) MXPopoverBackgroundType backgroundType;

@property (nonatomic, weak) UIView *targetView;

@end

@implementation MXPopover
@synthesize containView = _containView;

+ (instancetype)instance
{
    static id object;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [self new];
    });
    return object;
}

- (MXContainView *)containView
{
    if (!_containView) {
        _containView = [MXContainView new];
        _containView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerHandle:)];
        [_containView addGestureRecognizer:tap];
    };
    return _containView;
}

- (void)tapGestureRecognizerHandle:(UIGestureRecognizer *)gesture
{
    if (gesture.view == self.targetView || !self.enableTouchedDismiss) return;
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self dismissWithType:self.disMissType completion:nil];
    }
}

#pragma mark
#pragma mark === setter ===

+ (void)setDisMissType:(MXAnimationOutType)disMissType
{
    [[self instance] setDisMissType:disMissType];
}

+ (void)setTouchedDismissEnable:(BOOL)enable
{
    [[self instance] setEnableTouchedDismiss:enable];
}

+ (void)setBackgroundType:(MXPopoverBackgroundType)backgroundType
{
    MXPopover *popover = [self instance];
    popover.containView.backgroundView.type = backgroundType;
}

#pragma mark
#pragma mark === animation ===

- (void)animationWithTargetView:(UIView *)targetView inView:(UIView *)inView type:(MXAnimationInType)type completion:(void (^)(void))completion
{
    if (self.targetView.superview == self.containView) {
        [self.targetView removeFromSuperview];
    }
    self.containView.frame = inView.bounds;
    [self.containView.backgroundView reload];
    
    self.targetView = targetView;
    [self.containView addSubview:self.targetView];

    if (self.containView.superview == inView) {
        [inView bringSubviewToFront:self.containView];
    }
    else {
        [inView addSubview:self.containView];
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.containView.alpha = 1;
    }];

    [MXAnimation animatedView:targetView inType:type inDuration:0.5 inDelay:0 extraAnimation:nil completion:completion];
}

- (void)animationInWindowWithView:(UIView *)view type:(MXAnimationInType)type completion:(void (^)(void))completion
{
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    if (!window && [app.delegate respondsToSelector:@selector(window)]) {
        window = [app.delegate window];
    }
    [self animationWithTargetView:view inView:window type:type completion:completion];
}

- (void)dismissWithType:(MXAnimationOutType)type completion:(void (^)(void))completion
{
    [MXAnimation animatedView:self.targetView out:type outDuration:0.5 outDelay:0 extraAnimation:^{
        self.containView.alpha = 0;
    } completion:^{
        for (UIView *view in self.containView.subviews) {
            if (view == self.containView.backgroundView) continue;
            [view removeFromSuperview];
        }
        [self.containView removeFromSuperview];
        if (completion) completion();
    }];
}

+ (void)popView:(UIView *)view inView:(UIView *)inView animationType:(MXAnimationInType)type completion:(void (^)(void))completion
{
    [[self instance] animationWithTargetView:view inView:inView type:type completion:completion];
}

+ (void)popView:(UIView *)view animationType:(MXAnimationInType)type completion:(void (^)(void))completion
{
    [[self instance] animationInWindowWithView:view type:type completion:completion];
}

+ (void)dismissWithType:(MXAnimationOutType)type completion:(void (^)(void))completion
{
    [[self instance] dismissWithType:type completion:completion];
}

+ (void)dismiss:(void (^)(void))completion
{
    MXPopover *popover = [self instance];
    [popover dismissWithType:popover.disMissType completion:completion];
}

@end
