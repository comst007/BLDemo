//
//  LZUserAccount.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserAccount.h"

@implementation LZUserAccount

+ (instancetype)userWithName:(NSString *)aName
               headImagePath:(NSString *)aHeadImagePath
               lifePhotoPath:(NSString *)aLifePhotoPath{
    
    LZUserAccount *useraccount ;
    
    useraccount = [[LZUserAccount alloc] init];
    useraccount.name = aName;
    useraccount.iconPath = aHeadImagePath;
    useraccount.lifephotoPath = aLifePhotoPath;
    
    return useraccount;
    
}
@end
