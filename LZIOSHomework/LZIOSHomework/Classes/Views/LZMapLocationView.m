//
//  LZMapLocationView.m
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMapLocationView.h"

@interface LZMapLocationView ()


@end

@implementation LZMapLocationView

- (IBAction)reverseGeocoder{
    
    if ([self.delegate respondsToSelector:@selector(mapViewDidReverseGeocoding:)]) {
        [self.delegate mapViewDidReverseGeocoding:self];
    }
    
}


- (IBAction)geocoder{
    
    if ([self.delegate respondsToSelector:@selector(mapViewDidGeocoding:)]) {
        [self.delegate mapViewDidGeocoding:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    
}

@end
