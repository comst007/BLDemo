//
//  LZUserInfoViewController.m
//  LZNetworkingProURLSession
//
//  Created by comst on 15/10/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "LZUserInfoViewController.h"
#import "LZDownLoadRequest.h"
#import "LZGlobal.h"
#import "LZDownloadButton.h"
#import "LZIconRequest.h"
#import "MBProgressHUD.h"
#import "LZUploadRequest.h"
#import "NSString+LZMIMETYPE.h"
#import "LZMenuView.h"

typedef NS_ENUM(NSInteger, LZUploadButtonSate) {
    kUploadButtonSateSelect,
    kUploadButtonStateUpload
};

typedef NS_ENUM(NSInteger, LZMp3PlayingState) {
    kMp3PlayingSateNo,
    kMp3PlayingStatePlaying,
    kMp3PlayingStatePause
};
@interface LZUserInfoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVAudioPlayerDelegate>
@property (nonatomic, strong) LZDownLoadRequest *request;
@property (weak, nonatomic) IBOutlet UILabel *aboutSelfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headiconImageview;
@property (weak, nonatomic) IBOutlet LZDownloadButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;

@property (weak, nonatomic) IBOutlet UIImageView *uploadImageview;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) LZUploadButtonSate uploadButtonSate;
@property (nonatomic, strong) AVAudioPlayer *mp3Player;
@property (nonatomic, assign) LZMp3PlayingState mp3Playing;

@property (nonatomic, strong) LZMenuView *homeworkMenuView;

@end

@implementation LZUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [LZGlobal sharedglobal].userinfo.username;
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 1.0;
        
    }];
    self.aboutSelfLabel.text = [LZGlobal sharedglobal].userinfo.aboutself;
    
    LZIconRequest *iconRequest = [[LZIconRequest alloc] init];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [iconRequest headIconRequest:[LZGlobal sharedglobal].userinfo.headiconURL completionHandler:^(LZIconRequest *iconRequest) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            if (iconRequest.headIconImage != nil) {
                self.headiconImageview.image = iconRequest.headIconImage;
            }else{
                
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"headIcon 加载失败";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
            }
            
        });
        
    }];
    
    self.uploadButtonSate = kUploadButtonSateSelect;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mp3DownloadComplete) name:@"mp3DownloadComplationg" object:self.downloadButton];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAction)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)mp3DownloadComplete{
    self.playButton.hidden = NO ;
}

- (IBAction)playMp3:(UIButton *)sender {
    if (self.mp3Playing == kMp3PlayingStatePlaying) {
        [self.mp3Player pause];
        self.mp3Playing = kMp3PlayingStatePause;
        
    }else if (self.mp3Playing == kMp3PlayingStatePause)
    {
        [self.mp3Player play];
        self.mp3Playing = kMp3PlayingStatePlaying;
    }else{
        
        NSURL *mp3URL = [NSURL fileURLWithPath:self.downloadButton.mp3Path];
        AVAudioPlayer *mp3Player = [[AVAudioPlayer alloc] initWithContentsOfURL:mp3URL fileTypeHint:AVFileTypeMPEGLayer3 error:nil];
        mp3Player.delegate = self;
        self.mp3Player = mp3Player;
        self.mp3Playing = kMp3PlayingStatePlaying;
        [mp3Player prepareToPlay];
        [mp3Player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.mp3Playing = kMp3PlayingSateNo;
}
- (void)animationDidStart:(CAAnimation *)anim{
    
}





- (IBAction)uploadButtonClick:(UIButton *)sender {

    if (self.uploadButtonSate == kUploadButtonSateSelect) {

        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else {
            imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        imagePickerVC.delegate = self;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
    }else{
        [self displayLink];
        self.uploadButton.userInteractionEnabled = NO;
        LZUploadRequest *uploadRequest = [[LZUploadRequest alloc] init];
        NSData *imageData = UIImagePNGRepresentation(self.uploadImageview.image);
        [uploadRequest uploadRequestWithData:imageData mimeType:@"image/png" completionHandler:^(LZUploadRequest *uploadRequest) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.displayLink invalidate];
                self.displayLink = nil;
                [self.shapeLayer removeFromSuperlayer];
                self.shapeLayer = nil;
                MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                alert.minShowTime = 2;
                alert.mode = MBProgressHUDModeText;
                alert.labelText = @"上传成功";
                self.hidesBottomBarWhenPushed = YES;
                [self.view addSubview:alert];
                [alert show:YES];
                [alert hide:YES afterDelay:2];
                self.uploadButtonSate = kUploadButtonSateSelect;
                self.uploadButton.userInteractionEnabled = YES ;
                [self.uploadButton setTitle:@"选择上传图片" forState:UIControlStateNormal];
                
            });
        }];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"end pick ----%@", info);
    self.uploadImageview.image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.uploadButton setTitle:@"开始上传" forState:UIControlStateNormal];
    self.uploadButtonSate = kUploadButtonStateUpload;
    
   
    
    
}

- (void)beginUploadAnimation{
    
    if (self.shapeLayer == nil) {
        
        CGRect textRect =  [self.uploadButton titleRectForContentRect:self.uploadButton.bounds] ;
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        self.shapeLayer = shapeLayer;
        CGRect shapeLayerBounds = CGRectMake(0, 0, textRect.size.height, textRect.size.height);
        CGPoint  shapeLayerPosition = CGPointMake(textRect.origin.x - 15, textRect.origin.y + textRect.size.height * 0.5);
        
        shapeLayer.bounds = shapeLayerBounds;
        shapeLayer.position = shapeLayerPosition;
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineWidth = 2;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        
        [self.uploadButton.layer addSublayer:shapeLayer];
    }
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    
    self.startAngle = self.startAngle + M_PI * 0.4 ;
    
    if (self.startAngle > M_2_PI) {
        self.startAngle = self.startAngle - M_2_PI;
    }
    self.endAngle = self.startAngle + M_PI * 1.6;
    
    if (self.endAngle > M_2_PI) {
        self.endAngle = self.endAngle - M_2_PI;
    }
    [circlePath addArcWithCenter:CGPointMake(self.shapeLayer.bounds.size.width * 0.5, self.shapeLayer.bounds.size.width * 0.5) radius:self.shapeLayer.bounds.size.width * 0.5 - 1 startAngle:self.startAngle endAngle:self.endAngle clockwise:1];
    self.shapeLayer.path = circlePath.CGPath;

}

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(beginUploadAnimation)];
        _displayLink.frameInterval = 8;
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}


- (LZMenuView *)homeworkMenuView{
    if (!_homeworkMenuView) {
        _homeworkMenuView = [[LZMenuView alloc] initWithTitles:@[@"第一题", @"第二题",@"第三题",@"第四题",@"第五题",@"第六题"]];
    }
    return _homeworkMenuView;
}

- (void)swipeGestureAction{
    
    [self showHomeworkMenu:nil];
}

- (IBAction)showHomeworkMenu:(id)sender {
    
    [self.homeworkMenuView trigger];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

}

@end
