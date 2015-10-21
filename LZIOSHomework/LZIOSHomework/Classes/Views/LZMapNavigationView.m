//
//  LZMapNavigationView.m
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMapNavigationView.h"

@implementation LZMapNavigationView


- (IBAction)directionRequest{
    if ([self.delegate respondsToSelector:@selector(MapNavigationViewDidDirectionRequest:)]) {
        [self.delegate MapNavigationViewDidDirectionRequest:self];
    }
}

- (IBAction)trafficTypeChanged{
    
    if (self.traficTypeSegment.selectedSegmentIndex == 0) {
        self.trafficType = MKDirectionsTransportTypeWalking;
    }else{
        self.trafficType = MKDirectionsTransportTypeAutomobile;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
