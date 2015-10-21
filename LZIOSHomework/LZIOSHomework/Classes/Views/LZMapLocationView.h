//
//  LZMapLocationView.h
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class LZMapLocationView;

@protocol LZMapViewProtocal <NSObject>

- (void)mapViewDidReverseGeocoding:(LZMapLocationView *)mapLocationView;

- (void)mapViewDidGeocoding:(LZMapLocationView *)mapLocationView;
@end

@interface LZMapLocationView : UIView

@property (nonatomic, strong) IBOutlet UIButton *searchBUtton;

@property (nonatomic, strong) IBOutlet UITextField *longitudeTextfield;

@property (nonatomic, strong) IBOutlet UITextField *latitudeTextfield;

@property (nonatomic, strong) IBOutlet UITextField *locationDescTextfield;

@property (nonatomic, weak) id<LZMapViewProtocal> delegate;

@end
