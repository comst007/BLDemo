//
//  LZThreeViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZThreeViewController.h"

@interface LZThreeViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIPageControl *pagecontrol;
@end

@implementation LZThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg3"];
    self.imgView.image = img;
    self.title = @"Three";
    
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    self.scrollview = scrollview;
    scrollview.backgroundColor = [UIColor redColor];
    CGFloat scrollviewWidth = self.view.frame.size.width - 10 * 2;
    CGFloat scrollviewHeight = 500;
    scrollview.contentSize = CGSizeMake(scrollviewWidth * 5, scrollviewHeight);
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.delegate  = self;
    scrollview.bounces = NO;
    
    
    
    UIPageControl *pagecontrol = [[UIPageControl alloc] init];
    self.pagecontrol = pagecontrol;
    pagecontrol.numberOfPages = 5;
    pagecontrol.currentPage = 0;
    [pagecontrol addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventValueChanged];
    
    scrollview.translatesAutoresizingMaskIntoConstraints = NO;
    pagecontrol.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:scrollview];
    [self.view addSubview:pagecontrol];
    
    NSDictionary *dict = @{@"scrollview":scrollview, @"pagecontrol":pagecontrol};
    
    NSString *scrollviewVFLH = @"H:|-10-[scrollview]-10-|";
    NSString *pagecontrolVFLH = @"H:[pagecontrol(==100)]";
    NSString *VFLV = @"V:|-80-[scrollview(==500)]-10-[pagecontrol(==10)]";
    
    NSArray *scrollviewConstraints = [NSLayoutConstraint constraintsWithVisualFormat:scrollviewVFLH options:0 metrics:nil views:dict];
    
    NSArray *pagecontrolConstraints = [NSLayoutConstraint constraintsWithVisualFormat:pagecontrolVFLH options:0 metrics:nil views:dict];
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:VFLV options:NSLayoutFormatAlignAllCenterX metrics:nil views:dict];
    
    [self.view addConstraints:scrollviewConstraints];
    [self.view addConstraints:constraints];
    [pagecontrol addConstraints:pagecontrolConstraints];
    
    [self scrollviewContent];
    
    
    
}

- (void)scrollviewContent{
    CGFloat contentW = self.view.frame.size.width - 20;
    CGFloat contentH = 500;
    CGFloat contentY = 0 ;
    for (NSInteger i = 0; i< 5; i++) {
        CGFloat contentX = i * contentW;
        UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        [self.scrollview addSubview:newView];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:newView.bounds];
        [newView addSubview:imageView];
        NSString *imageName = [NSString stringWithFormat:@"bg%ld", i + 1];
        UIImage *img = [UIImage imageNamed:imageName];
        imageView.image = img;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.center = CGPointMake(newView.bounds.size.width * 0.5, newView.bounds.size.height * 0.5);
        NSString *text = [NSString stringWithFormat:@"%ld", i + 1];
        label.text = text;
        label.font = [UIFont boldSystemFontOfSize:40];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.6 alpha:1];
        
        [newView addSubview:label];
        
    }
}


#pragma mark - scrollview delegate
// 6
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     NSLog(@"%s", __func__);
}

// 4
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%s", __func__);
}

// 7
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
     NSLog(@"%s", __func__);
}

// 2
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     NSLog(@"%s", __func__);
    NSLog(@"offset(%lf, %lf)", scrollView.contentOffset.x, scrollView.contentOffset.y);
    CGFloat imgWidth = self.view.bounds.size.width - 20;
    self.pagecontrol.currentPage = (self.scrollview.contentOffset.x + imgWidth * 0.5) / imgWidth;
}

// 5
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
     NSLog(@"%s", __func__);
}

// 1
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     NSLog(@"%s", __func__);
}

// 3
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
     NSLog(@"%s", __func__);
}


# pragma mark - pagecontrol click

- (void)pageChanged{
     NSLog(@"%s", __func__);
}


@end
