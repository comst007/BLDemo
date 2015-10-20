//
//  LZTabBarItem.h
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, LZTabBarItemType) {
    LZTabBarItemTypeNormal = 0,
    LZTabBarItemTypeRise,
};



@interface LZTabBarItem : UIButton

@property (nonatomic, assign) LZTabBarItemType tabBarItemType;



@end

