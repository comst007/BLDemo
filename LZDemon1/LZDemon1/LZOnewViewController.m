//
//  LZOnewViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZOnewViewController.h"

@interface LZOnewViewController ()

@end

@implementation LZOnewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg1"];
   
    self.imgView.image = img;
    self.title = @"One";
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setBackgroundColor:[UIColor redColor]];
    [pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [presentBtn setBackgroundColor:[UIColor blueColor]];
    [presentBtn setTitle:@"present" forState:UIControlStateNormal];
    
    pushBtn.translatesAutoresizingMaskIntoConstraints = NO;
    presentBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:pushBtn];
    [self.view addSubview:presentBtn];
    
    NSDictionary *constraintDict = @{@"pushBtn":pushBtn, @"presentBtn":presentBtn};
    NSArray *pushBtnH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[pushBtn]-20-|" options:0 metrics:nil views:constraintDict];
    [self.view addConstraints:pushBtnH];
    
    NSArray *pushBtnV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[pushBtn(50)]-20-[presentBtn(==pushBtn)]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:constraintDict];
    
    [self.view addConstraints:pushBtnV];
    
    NSLayoutConstraint *presentBtnH = [NSLayoutConstraint constraintWithItem:presentBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:pushBtn attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    [self.view addConstraint:presentBtnH];
    
}



@end
