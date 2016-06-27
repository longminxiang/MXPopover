//
//  MXPopoverBackground.h
//  MXPopoverDemo
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 Eric Lung. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MXPopoverBackgroundType) {
    MXPopoverBackgroundTypeNone = 0,
    MXPopoverBackgroundTypeBlur,
};

@interface MXPopoverBackgroundView : UIView

@property (nonatomic, assign) MXPopoverBackgroundType type;

- (void)reload;

@end
