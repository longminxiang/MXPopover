//
//  ViewController.m
//  MXPopoverDemo
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 Eric Lung. All rights reserved.
//

#import "ViewController.h"
#import "MXPopover.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [MXPopover setTouchedDismissEnable:YES];
    
    [self afterPopup];
}

- (void)afterPopup
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self popup];
        [self afterPopup2];
    });
}

- (void)afterPopup2
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self popup1];
        [self afterPopup];
    });
}

- (IBAction)popup1
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"33333333";
    label.center = self.view.center;
    
    [MXPopover setBackgroundType:MXPopoverBackgroundTypeNone];
    [MXPopover popView:label animationType:MXAnimationSlideInBottomCenter completion:nil];
}


- (IBAction)popup
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"pop up with popover";
    label.center = self.view.center;

    [MXPopover setBackgroundType:MXPopoverBackgroundTypeBlur];
    [MXPopover popView:label animationType:MXAnimationSlideInLeftCenter completion:nil];
}

- (IBAction)dismiss
{
    [MXPopover dismiss:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
