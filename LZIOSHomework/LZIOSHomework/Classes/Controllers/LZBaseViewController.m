//
//  LZBaseViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZBaseViewController.h"

@interface LZBaseViewController ()

@end

@implementation LZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg1"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = self.view.bounds;
    
    self.imgView = imgView;
    
    [self.view addSubview:imgView];
    
}


@end
