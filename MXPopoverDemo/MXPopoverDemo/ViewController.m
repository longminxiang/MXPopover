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
        [self afterPopup];
    });
}

- (IBAction)popup
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.backgroundColor = [UIColor orangeColor];
    label.text = @"pop up with popover";
    
    [MXPopover popView:label animationType:MXAnimationSlideInBottomCenter completion:nil];
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
