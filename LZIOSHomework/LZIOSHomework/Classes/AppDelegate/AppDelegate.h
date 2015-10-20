//
//  AppDelegate.h
//  LZIOSHomework
//
//  Created by comst on 15/10/20.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTabBar.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, LZTabBarDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)loadUserinfoFrame;

- (void)loadUserLoginFrame;

- (void)loadNumberOneFrame;
@end

