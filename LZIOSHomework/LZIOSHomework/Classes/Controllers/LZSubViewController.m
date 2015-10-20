//
//  LZSubViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZSubViewController.h"

@interface LZSubViewController ()

@end

@implementation LZSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *dict = @{@"button":btn};
    
    NSString *VFLH = @"H:|-20-[button]-20-|";
    NSArray *btnH = [NSLayoutConstraint constraintsWithVisualFormat:VFLH options:0 metrics:nil views:dict];
    [self.view addConstraints:btnH];
    
    NSString *VFLV = @"V:[button(==50)]";
    
    NSArray *btnV = [NSLayoutConstraint constraintsWithVisualFormat:VFLV options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
    [btn addConstraints:btnV];
    
    NSLayoutConstraint *btnalign = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:1.0];
    [self.view addConstraint:btnalign];
    
}

#pragma mark - btn click

- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
