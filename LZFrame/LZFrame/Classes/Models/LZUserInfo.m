//
//  LZUserInfo.m
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZUserInfo.h"

@implementation LZUserInfo

- (instancetype)initWithDic:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.age = dict[@"age"];
        self.userID = dict[@"id"];
        self.headImageURL = dict[@"headImageUrl"];
        self.address = [LZAddress addressWithDict:dict[@"address"]];
        self.userName = dict[@"userName"];
    }
    return self;
}

+ (instancetype)userInfoWithDic:(NSDictionary *)dict{
    return [[LZUserInfo alloc] initWithDic:dict];
}
@end
