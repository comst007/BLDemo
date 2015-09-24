//
//  LZDetailViewController.m
//  LZtableview02
//
//  Created by comst on 15/9/24.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZDetailViewController.h"

@interface LZDetailViewController ()

@end

@implementation LZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    
    [self.view addSubview:imgview];
    
    self.imgview = imgview;
    
    self.title = self.useraccount.name;
    
    self.imgview.image = [[UIImage alloc] initWithContentsOfFile:self.useraccount.lifephotoPath];
    
}

@end
