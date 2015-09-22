//
//  LZUserAccount.h
//  LZtableview02
//
//  Created by comst on 15/9/23.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZUserAccount : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *iconPath;
@property (nonatomic, copy) NSString *lifephotoPath;

+ (instancetype)useraccountWithName:(NSString *)name andIconPath:(NSString *)iconpath andLifephotoPath:(NSString *)lifephotoPath;
@end
