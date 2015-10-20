//
//  LZTabBar.h
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZTabBarItem.h"
@protocol LZTabBarDelegate;
@interface LZTabBar : UIView
@property (nonatomic, copy) NSArray *tabBarItems;
@property (nonatomic, weak) id <LZTabBarDelegate> delegate;

@end

@protocol LZTabBarDelegate <NSObject>

- (void)tabBarDidSelectedRiseButton;

@end