//
//  LZUserInfo.h
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZAddress.h"
@interface LZUserInfo : NSObject
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *headImageURL;
@property (nonatomic, strong) LZAddress *address;
@property (nonatomic, copy) NSString *userName;

- (instancetype)initWithDic:(NSDictionary *)dict;

+ (instancetype)userInfoWithDic:(NSDictionary *)dict;
@end
