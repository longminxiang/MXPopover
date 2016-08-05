//
//  MXPopover.m
//
//  Created by eric on 14/11/7.
//  Copyright (c) 2014年 Eric Lung. All rights reserved.
//

#import "MXPopover.h"
#import <objc/runtime.h>

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

- (void)removeAllTargetView
{
    for (UIView *view in self.subviews) {
        if (view == self.backgroundView) continue;
        [view removeFromSuperview];
    }
}

@end

#pragma mark === MXPopver ===

@interface MXPopover ()<UIGestureRecognizerDelegate>

@property (nonatomic, readonly) MXContainView *containView;

@property (nonatomic, weak) UIView *targetView;

@property (nonatomic, weak) UIView *inView;

@property (nonatomic, copy) void (^showCompletion)();

@property (nonatomic, copy) void (^dismissCompletion)();

@end

@implementation MXPopover
@synthesize containView = _containView;

+ (instancetype)popView:(UIView *)targetView
{
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    if (!window && [app.delegate respondsToSelector:@selector(window)]) {
        window = [app.delegate window];
    }
    return [self popView:targetView inView:window];
}

+ (instancetype)popView:(UIView *)targetView inView:(UIView *)view
{
    MXPopover *popover = [MXPopover new];
    popover.targetView = targetView;
    popover.inView = view;
    return popover;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundType = MXPopoverBackgroundTypeBlur;
        self.showAnimation = MXAnimationSlideInTopCenter;
        self.dismissAnimation = MXAnimationSlideOutBottom;
        self.enableTouchedDismiss = YES;
    }
    return self;
}

- (MXContainView *)containView
{
    if (!_containView) {
        _containView = [MXContainView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerHandle:)];
        tap.delegate = self;
        [_containView addGestureRecognizer:tap];
    };
    return _containView;
}

- (void)setTargetView:(UIView *)targetView
{
    _targetView = targetView;
    _targetView.autoresizingMask = UIViewAutoresizingNone;
}

- (void)show
{
    [self.containView removeAllTargetView];
    [self.containView addSubview:self.targetView];
    
    if (self.containView.superview != self.inView || self.backgroundType != self.containView.backgroundView.type) {
        if (self.backgroundType != self.containView.backgroundView.type) {
            [self.containView removeFromSuperview];
        }
        self.containView.frame = self.inView.bounds;
        [self.containView.backgroundView setType:self.backgroundType blurWithView:self.inView];
        [self.inView addSubview:self.containView];
        [self.inView bringSubviewToFront:self.containView];
        self.containView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.containView.alpha = 1;
        }];
    }
    else {
        [self.inView bringSubviewToFront:self.containView];
    }
    [MXAnimation animatedView:self.targetView inType:self.showAnimation inDuration:0.5 inDelay:0 extraAnimation:nil completion:self.showCompletion];
}

- (void)dismiss
{
    [MXAnimation animatedView:self.targetView out:self.dismissAnimation outDuration:0.35 outDelay:0 extraAnimation:^{
        self.containView.alpha = 0;
    } completion:^{
        [self.containView removeAllTargetView];
        [self.containView removeFromSuperview];
        if (self.dismissCompletion) self.dismissCompletion();
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.containView];
    return !CGRectContainsPoint(self.targetView.frame, point) && self.enableTouchedDismiss;
}

- (void)tapGestureRecognizerHandle:(UIGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self dismiss];
    }
}

@end

@interface UIView ()

@property (nonatomic, strong) MXPopover *popover;

@end

@implementation UIView (MXPopover)

- (MXPopover *)popover
{
    MXPopover *popover = objc_getAssociatedObject(self, _cmd);
    if (!popover) {
        popover = [MXPopover new];
        self.popover = popover;
    }
    return popover;
}

- (void)setPopover:(MXPopover *)popover
{
    popover.inView = self;
    __weak typeof(self) weaks = self;
    [popover setDismissCompletion:^{
        objc_setAssociatedObject(weaks, @selector(popover), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }];
    objc_setAssociatedObject(self, @selector(popover), popover, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showPopoverWithView:(UIView *)targetView
{
    [self showPopoverWithView:targetView popover:nil];
}

- (void)showPopoverWithView:(UIView *)targetView popover:(void (^)(MXPopover *popover))block
{
    self.popover.targetView = targetView;
    if (block) block(self.popover);
    [self.popover show];
}

- (void)dismissPopover
{
    [self.popover dismiss];
}

@end
