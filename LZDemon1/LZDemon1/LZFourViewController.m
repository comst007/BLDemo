//
//  LZFourViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFourViewController.h"

@interface LZFourViewController ()<UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webview;
@property (nonatomic, weak) UIToolbar *toolbar;
@property (nonatomic, weak) UIActivityIndicatorView *indicator;
@end

@implementation LZFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg4"];
    self.imgView.image = img;
    self.title = @"four";
    
    UIWebView *webview = [[UIWebView alloc] init];
    self.webview = webview;
    webview.backgroundColor = [UIColor greenColor];
    webview.delegate = self;
    
    NSString *urlString = @"http://www.baidu.com";
    
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webview loadRequest:request];
    
    

    UIToolbar *toolbar = [[UIToolbar alloc] init];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forword)];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    item4.width = 50;
    
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    toolbar.items = @[item1, item4, item2, item5, item3];
    
    
    
    
    
    toolbar.backgroundColor = [UIColor blueColor];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.toolbar = toolbar;
    self.indicator = indicator;
    
    [self.view addSubview:webview];
    [self.view addSubview:toolbar];
    [self.view addSubview:indicator];
    
    [self layoutSubview];
    

}


- (void)layoutSubview{
    CGFloat toolbarH = 50;
    CGFloat toolbarW = self.view.frame.size.width;
    
    CGFloat webviewH = self.view.frame.size.height - 20 - 44 - 44 - 50;
    CGFloat webviewW = self.view.frame.size.width;
    CGFloat webviewX = 0;
    CGFloat webviewY = 20 + 44;
    
    CGFloat toolbarX = 0 ;
    CGFloat toolbarY = webviewH + webviewY;
    
    CGFloat indicatorX = webviewW * 0.5;
    CGFloat indicatorY = webviewY + webviewH * 0.5;
    
    self.webview.frame = CGRectMake(webviewX, webviewY, webviewW, webviewH);
    self.toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    self.indicator.center = CGPointMake(indicatorX, indicatorY);
}


# pragma mark - webview delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     NSLog(@"%s", __func__);
    [self.indicator stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSLog(@"%s", __func__);
    //self.indicator.hidden = NO;
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
     NSLog(@"%s", __func__);
    [self.indicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.indicator startAnimating];
     NSLog(@"%s", __func__);
}


# pragma mark - barbuttonitem method

- (void)back{
    [self.webview goBack];
}

- (void)forword{
    [self.webview goForward];
}

- (void)refresh{
    [self.webview reload];
}
@end
