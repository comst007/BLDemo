//
//  LZAnnotation.m
//  LZDemon1
//
//  Created by comst on 15/9/22.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAnnotation.h"

@implementation LZAnnotation 

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andSubtitle:(NSString *)subtitle{
    
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}
@end
