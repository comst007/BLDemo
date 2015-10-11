//
//  LZAddress.m
//  LZFrame
//
//  Created by comst on 15/10/11.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAddress.h"

@implementation LZAddress
- (instancetype)initWithDict:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.cityID = dict[@"id"];
        self.cityName = dict[@"name"];
    }
    return self;
}

+ (instancetype)addressWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
