//
//  LZTwoViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZTwoViewController.h"

@interface LZTwoViewController ()

@end

@implementation LZTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg2"];
    self.imgView.image = img;
    self.navigationItem.title = @"Two";
}



@end
