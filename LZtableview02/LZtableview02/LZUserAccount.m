//
//  LZUserAccount.m
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserAccount.h"

@implementation LZUserAccount

+ (instancetype)useraccountWithName:(NSString *)name andIconPath:(NSString *)iconpath andLifephotoPath:(NSString *)lifephotoPath{
    
    LZUserAccount *useraccount ;
    
    useraccount = [[LZUserAccount alloc] init];
    useraccount.name = name;
    useraccount.iconPath = iconpath;
    useraccount.lifephotoPath = lifephotoPath;
    
    return useraccount;
    
}
@end
