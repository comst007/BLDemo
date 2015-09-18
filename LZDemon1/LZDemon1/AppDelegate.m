//
//  AppDelegate.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "AppDelegate.h"
#import "LZOnewViewController.h"
#import "LZTwoViewController.h"
#import "LZThreeViewController.h"
#import "LZFourViewController.h"
#import "LZFiveViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)loadMainFrame{
    
    LZOnewViewController *oneView = [[LZOnewViewController alloc] init];
    
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:oneView];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    
    nvc1.tabBarItem.image = [UIImage imageNamed:@"one"];
    nvc1.tabBarItem.title = @"one";
    
    LZTwoViewController *twoView = [[LZTwoViewController alloc] init];
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:twoView];
    
    
    nvc2.tabBarItem.image = [UIImage imageNamed:@"two"];
    nvc2.tabBarItem.title = @"two";
    
    LZThreeViewController *threeView = [[LZThreeViewController alloc] init];
    
    UINavigationController *nvc3 = [[UINavigationController alloc] initWithRootViewController:threeView];
    
    
    
    nvc3.tabBarItem.image = [UIImage imageNamed:@"three"];
    nvc3.tabBarItem.title = @"three";
    
    LZFourViewController *fourView = [[LZFourViewController alloc] init];
    UINavigationController *nvc4 = [[UINavigationController alloc] initWithRootViewController:fourView];
    
    
    nvc4.tabBarItem.image = [UIImage imageNamed:@"four"];
    nvc4.tabBarItem.title = @"four";
    
    
    LZFiveViewController *fiveView = [[LZFiveViewController alloc] init];
    UINavigationController *nvc5 = [[UINavigationController alloc] initWithRootViewController:fiveView];
    
  
    
    nvc5.tabBarItem.image = [UIImage imageNamed:@"five"];
    nvc5.tabBarItem.title = @"five";
    
    
    
    tabBar.viewControllers = @[nvc1, nvc2, nvc3, nvc4, nvc5];
    self.window.rootViewController = tabBar;
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self loadMainFrame];
    
    [self.window makeKeyAndVisible];
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
