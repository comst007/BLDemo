//
//  LZMapViewController.m
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMapViewController.h"

@interface LZMapViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapSegmentControl;
@property (weak, nonatomic) IBOutlet LZMapLocationView *locationView;
@property (weak, nonatomic) IBOutlet LZMapNavigationView *navigationView;

@end

@implementation LZMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapSegmentControl.selectedSegmentIndex = 0;
}
- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    if (self.mapSegmentControl.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.locationView.alpha = 1.0;
            self.navigationView.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            self.locationView.alpha = 0.0;
            self.navigationView.alpha = 1.0;
        }];
    }
}


@end
