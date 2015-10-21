//
//  LZMapNavigationView.h
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class LZMapNavigationView;

@protocol LZMapNavigationViewProtocal <NSObject>

- (void)MapNavigationViewDidDirectionRequest:(LZMapNavigationView *)mapNavigationView;

@end

@interface LZMapNavigationView : UIView

@property (nonatomic, strong) IBOutlet UITextField *start;

@property (nonatomic, strong) IBOutlet UITextField *end;

@property (nonatomic, strong) IBOutlet UISegmentedControl  *traficTypeSegment;

@property (nonatomic, weak) id<LZMapNavigationViewProtocal>  delegate;
@property (nonatomic, assign) MKDirectionsTransportType trafficType;
@end
