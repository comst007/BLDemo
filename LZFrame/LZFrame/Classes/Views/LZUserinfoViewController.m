//
//  LZUserinfoViewController.m
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserinfoViewController.h"
#import "LZGlobal.h"
#import "LZLoadIconRequest.h"
@interface LZUserinfoViewController ()<LZLoadIconRequestProtocal>
@property (weak, nonatomic) IBOutlet UIImageView *headImageview;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *downloadIndicator;

@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressview;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) LZLoadIconRequest *request;
@end

@implementation LZUserinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LZUserInfo *userinfo = [LZGlobal sharedglobal].userinfo;

    self.navigationItem.title = userinfo.userName;
   // [self.downloadIndicator startAnimating];
    
    
}


- (IBAction)startDownload:(UIButton *)sender {
    if (self.loading) {
        return;
    }
    self.loading = YES;
    self.headImageview.image = nil;
   
    [self.downloadIndicator startAnimating];
    self.downloadProgressview.progress = 0;
    [self.request sendRequestWithURL:[LZGlobal sharedglobal].userinfo.headImageURL delegate:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //[self.downloadIndicator stopAnimating];
}

- (LZLoadIconRequest *)request{
    
    if (!_request) {
        _request = [[LZLoadIconRequest alloc] init];
    }
    return _request;
}


#pragma mark - downloadrequest delegate

- (void)loadIconRequestDidSuccess:(LZLoadIconRequest *)loadIconRequest{
    [self.downloadIndicator stopAnimating];
    self.loading = NO;
    self.headImageview.image = [UIImage imageWithData:loadIconRequest.recvData];
}

- (void)loadIconRequestDidReceiveData:(LZLoadIconRequest *)loadIconRequest{
    
    self.downloadProgressview.progress = loadIconRequest.recvSum / (loadIconRequest.totalLength * 1.0);
}

- (void)loadIconRequestDidFail:(LZLoadIconRequest *)loadIconRequest error:(NSError *)error{
    [self.downloadIndicator stopAnimating];
    self.loading = NO;
}
@end
