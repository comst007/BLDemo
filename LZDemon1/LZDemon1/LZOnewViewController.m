//
//  LZOnewViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZOnewViewController.h"
#import "LZSubViewController.h"
@interface LZOnewViewController ()<UIAlertViewDelegate, UIActionSheetDelegate>

@end

@implementation LZOnewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg1"];
   
    self.imgView.image = img;
    self.title = @"One";
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setBackgroundColor:[UIColor clearColor]];
    [pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *pushBtnImg = [UIImage imageNamed:@"blueButton"];
    UIImage *pushBtnStretchImg = [pushBtnImg resizableImageWithCapInsets:UIEdgeInsetsMake(pushBtnImg.size.height * 0.5, pushBtnImg.size.width * 0.5, pushBtnImg.size.height * 0.5, pushBtnImg.size.width * 0.5)];
    [pushBtn setBackgroundImage:pushBtnStretchImg forState:UIControlStateNormal];

    
    UIButton *presentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [presentBtn setBackgroundColor:[UIColor clearColor]];
    [presentBtn setTitle:@"present" forState:UIControlStateNormal];
    [presentBtn addTarget:self action:@selector(presentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIImage *presentImg = [UIImage imageNamed:@"whiteButton"];
    CGFloat imgHeight = presentImg.size.height;
    CGFloat imgWidth = presentImg.size.width;
    
    UIImage *presentStretchImg = [presentImg resizableImageWithCapInsets:UIEdgeInsetsMake(imgHeight * 0.5, imgWidth * 0.5, imgHeight * 0.5, imgWidth * 0.5)];
    [presentBtn setBackgroundImage:presentStretchImg forState:UIControlStateNormal];
    
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
    
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"bg5"];
    imgView.backgroundColor = [UIColor whiteColor];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imgView];
    NSString *imgViewVFLH = @"H:|-20-[imgView]-20-|";
    NSString *imgVIewVFLV = @"V:[presentBtn]-20-[imgView(==100)]";
    NSDictionary *desDict = @{@"imgView":imgView, @"presentBtn":presentBtn};
    NSArray *imgViewConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:imgViewVFLH options:0 metrics:nil views:desDict];
    
    [self.view addConstraints:imgViewConstraintsH];
    
    NSArray *imgViewConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:imgVIewVFLV options:0 metrics:nil views:desDict];
    
    [self.view addConstraints:imgViewConstraintsV];
    
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    label.backgroundColor = [UIColor grayColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    NSString *text = @"aslka;sjldf;kja;lskdjfl;asdjfokasjdl;fjalskdjfl;kasdjflkasjdlfkjasdlkfjlaskdjflkasjdlkfjasdlkfjalsksdfsadfsadfsfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasd.";
    
    label.text = text;
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:15];
    CGFloat textW = self.view.bounds.size.width - 20 * 2;
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(textW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    CGFloat textheight = ceil(textSize.height);
    
    NSString *labelVFLH = @"H:|-20-[label]-20-|";
    NSString *labelVFLV = @"V:[imagView]-20-[label(==textH)]";
    NSDictionary *labelDict = @{@"label":label, @"imagView":imgView};
    NSArray *labelConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:labelVFLH options:0 metrics:nil views:labelDict];
    [self.view addConstraints:labelConstraintsH];
    NSArray *labelConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:labelVFLV options:0 metrics:@{@"textH":@(textheight)} views:labelDict];
    
    [self.view addConstraints:labelConstraintsV];
    
    UIBarButtonItem *righItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick)];
    self.navigationItem.rightBarButtonItem = righItem;
    
    
    
}


#pragma mark - btn click

- (void)pushBtnClick{
    LZSubViewController *vc = [[LZSubViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)presentBtnClick{
    LZSubViewController *vc = [[LZSubViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - right barbutton item click

- (void)itemClick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"edit" message:@"hello world" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"cancel",@"sure",nil];
    
    [alert show];
}

#pragma mark - alertview delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString: @"OK"]) {
       UIActionSheet *actsheet =  [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"destructive" otherButtonTitles:@"Ok", nil];
        
        //[actsheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
//        [actsheet showFromTabBar:self.tabBarController.tabBar];
        [actsheet showInView:self.view.window];
        
        
    }
}

#pragma mark actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"%@", title);
}
@end
