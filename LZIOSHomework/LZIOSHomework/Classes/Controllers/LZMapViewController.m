//
//  LZMapViewController.m
//  LZIOSHomework
//
//  Created by comst on 15/10/21.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZMapViewController.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#include "LZAnnotation.h"
#import "LZMapNavigationView.h"
@interface LZMapViewController ()<LZMapViewProtocal, CLLocationManagerDelegate, MKMapViewDelegate, LZMapNavigationViewProtocal>
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapSegmentControl;
@property (weak, nonatomic) IBOutlet LZMapLocationView *locationView;
@property (weak, nonatomic) IBOutlet LZMapNavigationView *navigationView;

@property (nonatomic, strong) CLGeocoder *geoCoder;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;

@end

@implementation LZMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapSegmentControl.selectedSegmentIndex = 0;
    self.locationView.delegate = self;
    self.mapview.mapType = MKMapTypeStandard;
    self.mapview.showsUserLocation = YES;
    self.mapview.delegate = self;
    self.navigationView.delegate = self;
}


- (void)MapNavigationViewDidDirectionRequest:(LZMapNavigationView *)mapNavigationView{
     __weak typeof(self) weakSelf = self;
    [self.geoCoder geocodeAddressString:mapNavigationView.start.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.view];
            
            alert.mode = MBProgressHUDModeText;
            alert.labelText = @"起点位置无法定位";
            alert.minShowTime = 1;
            alert.removeFromSuperViewOnHide = YES;
            
            [weakSelf.view addSubview:alert];
            
            [alert show:YES];
            
            [alert hide:YES afterDelay:1];
 
        }else{
            CLPlacemark *startItem = [placemarks firstObject];
            MKPlacemark *startPlaceItem = [[MKPlacemark alloc] initWithPlacemark:startItem];
            MKMapItem *startMapItem = [[MKMapItem alloc] initWithPlacemark:startPlaceItem];
            
            [weakSelf.geoCoder geocodeAddressString:mapNavigationView.end.text completionHandler:^(NSArray *placemarks, NSError *error) {
                if (error) {
                    MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.view];
                    
                    alert.mode = MBProgressHUDModeText;
                    alert.labelText = @"终点点位置无法定位";
                    alert.minShowTime = 1;
                    alert.removeFromSuperViewOnHide = YES;
                    
                    [weakSelf.view addSubview:alert];
                    
                    [alert show:YES];
                    
                    [alert hide:YES afterDelay:1];
                }else{
                    CLPlacemark *endItem = [placemarks firstObject];
                    MKPlacemark *endPlaceItem = [[MKPlacemark alloc] initWithPlacemark:endItem];
                    MKMapItem *endMapItem = [[MKMapItem alloc] initWithPlacemark:endPlaceItem];
                    
                    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
                    directionRequest.source = startMapItem;
                    directionRequest.destination = endMapItem;
                    directionRequest.transportType = mapNavigationView.trafficType;
                    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
                    
                    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                        if (error) {
                            MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.view];
                            
                            alert.mode = MBProgressHUDModeText;
                            alert.labelText = @"导航失败";
                            alert.minShowTime = 1;
                            alert.removeFromSuperViewOnHide = YES;
                            
                            [weakSelf.view addSubview:alert];
                            
                            [alert show:YES];
                            
                            [alert hide:YES afterDelay:1];
                        }
                        if (error ==nil) {
                            MKRoute *route = [response.routes firstObject];
                            [weakSelf.mapview addOverlay:route.polyline];
                        }
                    }];
                }
            }];
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *lineRender = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    
    lineRender.strokeColor = [UIColor blueColor];
    lineRender.lineCap = kCGLineCapRound;
    lineRender.lineJoin = kCGLineJoinRound;
    lineRender.lineWidth = 3;
    
    return lineRender;
}

/**
 *  114.036807,22.679805
    114.030339,22.674603
 
 *
 *  @param sender <#sender description#>
 */
- (IBAction)addAnnotation:(id)sender {
    
    LZAnnotation *item1 = [[LZAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(22.679805, 114.036807) andTitle:@"location1" andSubtitle:@"adsfdfasd"];
    
     LZAnnotation *item2 = [[LZAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(22.674603, 114.030339) andTitle:@"location2" andSubtitle:@"123456789"];
    
    [self.mapview addAnnotations:@[item1, item2]];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [self.mapview setRegion:MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1)) animated:YES];
}

- (IBAction)getMyLocation:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted) {
        
        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
        
        alert.mode = MBProgressHUDModeText;
        alert.labelText = @"请允许程序访问您的位置";
        alert.minShowTime = 1;
        alert.removeFromSuperViewOnHide = YES;
        
        [self.view addSubview:alert];
        
        [alert show:YES];
        
        [alert hide:YES afterDelay:1];
        
    }else if (status == kCLAuthorizationStatusNotDetermined){
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }else{
        [self.locationManager startUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }else{
        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
        
        alert.mode = MBProgressHUDModeText;
        alert.labelText = @"主人不允许获取位置";
        alert.minShowTime = 1;
        alert.removeFromSuperViewOnHide = YES;
        
        [self.view addSubview:alert];
        
        [alert show:YES];
        
        [alert hide:YES afterDelay:1];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *curentLocation = [locations lastObject];
    self.locationView.longitudeTextfield.text = [NSString stringWithFormat:@"%lf", curentLocation.coordinate.longitude];
    self.locationView.latitudeTextfield.text = [NSString stringWithFormat:@"%lf", curentLocation.coordinate.latitude];
    [self mapViewDidReverseGeocoding:self.locationView];
    [self.locationManager stopUpdatingLocation];
    
}


- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 3;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    if (self.mapSegmentControl.selectedSegmentIndex == 0) {
        [UIView animateWithDuration:1.0 animations:^{
            self.locationView.alpha = 1.0;
            self.navigationView.alpha = 0;
        }];
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            self.locationView.alpha = 0.0;
            self.navigationView.alpha = 1.0;
        }];
    }
}

/**
 *  114.045128,22.676294
 *
 *  @param mapLocationView <#mapLocationView description#>
 */
- (void)mapViewDidReverseGeocoding:(LZMapLocationView *)mapLocationView{
    
    CGFloat longitude = [mapLocationView.longitudeTextfield.text doubleValue];
    CGFloat latitude = [mapLocationView.latitudeTextfield.text doubleValue];
    CLLocation *searchLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
     __weak typeof(self) weakSelf = self;
    [self.geoCoder reverseGeocodeLocation:searchLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            
                        MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.view];
            
                        alert.mode = MBProgressHUDModeText;
                        alert.labelText = @"找不到坐标对应的位置";
                        alert.minShowTime = 1;
                        alert.removeFromSuperViewOnHide = YES;
            
                        [weakSelf.view addSubview:alert];
            
                        [alert show:YES];
                        
                        [alert hide:YES afterDelay:1];
        }else{
            CLPlacemark *placemarkItem = [placemarks objectAtIndex:0];
            mapLocationView.locationDescTextfield.text = [NSString stringWithFormat:@"%@-%@-%@-%@", placemarkItem.country, placemarkItem.administrativeArea,  placemarkItem.locality, placemarkItem.thoroughfare];
        }
    }];
    
}

/**
 *  广东省深圳市龙华新区和平路
 *
 *  @param mapLocationView <#mapLocationView description#>
 */
- (void)mapViewDidGeocoding:(LZMapLocationView *)mapLocationView{
     __weak typeof(self) weakSelf = self;
    [self.geoCoder geocodeAddressString:mapLocationView.locationDescTextfield.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:weakSelf.view];
            
            alert.mode = MBProgressHUDModeText;
            alert.labelText = @"找不到地理位置对应的坐标";
            alert.minShowTime = 1;
            alert.removeFromSuperViewOnHide = YES;
            
            [weakSelf.view addSubview:alert];
            
            [alert show:YES];
            
            [alert hide:YES afterDelay:1];
        }else{
            
            CLPlacemark *item = [placemarks objectAtIndex:0];
            
            mapLocationView.longitudeTextfield.text = [NSString stringWithFormat:@"%lf", item.location.coordinate.longitude];
            
            mapLocationView.latitudeTextfield.text = [NSString stringWithFormat:@"%lf", item.location.coordinate.latitude];
        }
    }];
}

- (CLGeocoder *)geoCoder{
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
        //self.view.layer.masksToBounds
    }
    return _geoCoder;
}



@end
