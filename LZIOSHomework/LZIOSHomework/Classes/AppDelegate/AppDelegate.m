//
//  AppDelegate.m
//  LZIOSHomework
//
//  Created by comst on 15/10/20.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "AppDelegate.h"
#import "LZUserloginViewController.h"
#import "LZOnewViewController.h"
#import "LZTwoViewController.h"
#import "LZThreeViewController.h"
#import "LZFourViewController.h"
#import "LZFiveViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadUserinfoFrame{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserInfo" bundle:[NSBundle mainBundle]];
    UINavigationController *nvc = [sb instantiateViewControllerWithIdentifier:@"LZUserInfoNav"];
    self.window.rootViewController = nvc;
}

- (void)loadUserLoginFrame{
    
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LZUserloginViewController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LZUserLogin"];
    self.window.rootViewController = loginVC;
    
}

- (void)loadNumberOneFrame{
    
    
    LZOnewViewController *oneView = [[LZOnewViewController alloc] init];
    
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:oneView];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    

    
    LZTwoViewController *twoView = [[LZTwoViewController alloc] init];
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:twoView];
    
    

    
    LZThreeViewController *threeView = [[LZThreeViewController alloc] init];
    
    UINavigationController *nvc3 = [[UINavigationController alloc] initWithRootViewController:threeView];
    
 
    
    LZFourViewController *fourView = [[LZFourViewController alloc] init];
    UINavigationController *nvc4 = [[UINavigationController alloc] initWithRootViewController:fourView];
    

    
    LZFiveViewController *fiveView = [[LZFiveViewController alloc] init];
    UINavigationController *nvc5 = [[UINavigationController alloc] initWithRootViewController:fiveView];
    
   

    
    
    tabBarVC.viewControllers = @[nvc1, nvc2, nvc3, nvc4, nvc5];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LZTabBar *tabBar = [[LZTabBar alloc] initWithFrame:tabBarVC.tabBar.bounds];
    
    CGFloat normalButtonWidth = ([UIScreen mainScreen].bounds.size.width * 3 / 4) / 5;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = [UIScreen mainScreen].bounds.size.width / 4;
    
    
    
    LZTabBarItem *item1 = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight) title:@"one" normalImageName:@"one" selectedImageName:@"Star" tabBarItemType:LZTabBarItemTypeNormal];
    
    LZTabBarItem *item2 = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight) title:@"two" normalImageName:@"two" selectedImageName:@"Star" tabBarItemType:LZTabBarItemTypeNormal];

    LZTabBarItem *item3 = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, normalButtonWidth, tabBarHeight) title:@"three" normalImageName:@"three" selectedImageName:@"Star" tabBarItemType:LZTabBarItemTypeNormal];
    
    LZTabBarItem *item4 = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3, 0, normalButtonWidth, tabBarHeight) title:@"four" normalImageName:@"four" selectedImageName:@"Star" tabBarItemType:LZTabBarItemTypeNormal];
    
     LZTabBarItem *item5 = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 4, 0, normalButtonWidth, tabBarHeight) title:@"five" normalImageName:@"five" selectedImageName:@"Star" tabBarItemType:LZTabBarItemTypeNormal];
    
     LZTabBarItem *item6 = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 5, 0, publishItemWidth, tabBarHeight) title:@"six" normalImageName:@"six" selectedImageName:@"six" tabBarItemType:LZTabBarItemTypeRise];
    
    tabBar.tabBarItems = @[item1,item2, item3, item4, item5, item6];
    tabBar.delegate = self;
    
    
    
    [tabBarVC.tabBar addSubview:tabBar];
    
    self.window.rootViewController = tabBarVC;
    

    
}

- (LZTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LZTabBarItemType)tabBarItemType {
    LZTabBarItem *item = [[LZTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    //[item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}


- (void)tabBarDidSelectedRiseButton {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"选项一", @"选项二", @"选项三", nil];
    [actionSheet showInView:viewController.view];
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}


- (void)loadNumberFiveFrame{
    UIStoryboard *SB = [UIStoryboard storyboardWithName:@"LZMapApp" bundle:nil];
    
    UINavigationController *nvc = [SB instantiateViewControllerWithIdentifier:@"LZMapAppNav"];
    self.window.rootViewController = nvc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadUserLoginFrame];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
