//
//  LZFourViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFourViewController.h"

@interface LZFourViewController ()

@end

@implementation LZFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg4"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = self.view.bounds;
    
    
    [self.view addSubview:imgView];
}



@end
