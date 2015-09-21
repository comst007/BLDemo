//
//  LZFiveViewController.m
//  LZDemon1
//
//  Created by comst on 15/9/18.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZFiveViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface LZFiveViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) MKMapView *mapview;
@end

@implementation LZFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *img = [UIImage imageNamed:@"bg5"];
    
    self.imgView.image = img;
    self.title = @"Five";
    
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    
    [self.view addSubview:label];
    label.frame = CGRectMake(0, 64, self.view.frame.size.width, 60);
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.7 alpha:1];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.text = @"hello world";
    
    
    
    if([CLLocationManager locationServicesEnabled] == YES){
        
        NSLog(@"location service enabled");
        
    }
    
    if ([CLLocationManager headingAvailable] == YES) {
        NSLog(@"heading service available");
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSLog(@"user authorization status: %i", status);
    
    [self.manager startUpdatingHeading];
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
    
        [self.manager startUpdatingLocation];
        
        
    }else if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted){
        NSLog(@" not authorization");
    }else{
        [self.manager requestWhenInUseAuthorization];
    }
    
    
    
    self.mapview = [[MKMapView alloc] init];
    [self.view addSubview:self.mapview];
    CGFloat mapviewX = 0;
    CGFloat mapviewY = CGRectGetMaxY(self.label.frame);
    CGFloat mapviewW = self.view.bounds.size.width;
    CGFloat mapviewH = self.view.bounds.size.height - 20 - 44 - self.label.frame.size.height - 44;
    self.mapview.frame = CGRectMake(mapviewX, mapviewY, mapviewW, mapviewH);
    self.mapview.delegate = self;
    self.mapview.region = MKCoordinateRegionMake(self.mapview.userLocation.location.coordinate, MKCoordinateSpanMake(1, 1));
    self.mapview.showsUserLocation = YES;
    self.mapview.showsBuildings = YES;
    self.mapview.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapview.mapType = MKMapTypeStandard;
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapviewTapped:)];
    tapgesture.numberOfTapsRequired = 1;
    
    [self.mapview addGestureRecognizer:tapgesture];
    
    
}

- (CLLocationManager *)manager{
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.delegate = self;
    }
    return _manager;
}

#pragma mark - locationmanager delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
     NSLog(@"%s, changed status: %i", __func__, status);
    [manager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
     NSLog(@"%s", __func__);
    
    CLLocation *currentlocation = [locations lastObject];
    
    [manager stopUpdatingLocation];
    
    //self.label.text = currentlocation.description;
    NSLog(@"floor: %li", currentlocation.floor.level);
    NSLog(@"altitude:%lf", currentlocation.altitude);
    NSDate *date = currentlocation.timestamp;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    format.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    NSString *dateString = [format stringFromDate:date];
    NSLog(@"date: %@", dateString);
    NSLog(@"heading:%lf", self.manager.heading.trueHeading);
    
    __weak typeof(self) weakSelf = self;
    
    [self.geocoder reverseGeocodeLocation:currentlocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"解析失败");
        }
        CLPlacemark *place = [placemarks firstObject];
        weakSelf.label.text = place.name;
        NSLog(@"addreedic: %@", place.addressDictionary);
        NSLog(@"ISOcountry: %@", place.ISOcountryCode);
        NSLog(@"country: %@", place.country);
        NSLog(@"postalcode: %@", place.postalCode);
        NSLog(@"administrativeArea: %@", place.administrativeArea);
        NSLog(@"subadministrativeArea: %@", place.subAdministrativeArea);
        NSLog(@"locality: %@", place.locality);
        NSLog(@"subLocality: %@", place.subLocality);
        NSLog(@"thoronghfare: %@", place.thoroughfare);
        NSLog(@"subThroroughfare: %@", place.subThoroughfare);
        NSLog(@"region: %@", place.region);
        
    }];
}

- (CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
     NSLog(@"%s, newheading: %lf", __func__, newHeading.trueHeading);
    [self.manager stopUpdatingHeading];
}

#pragma mark - MKMapview delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
     NSLog(@"%s", __func__);
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
     NSLog(@"%s", __func__);
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
     NSLog(@"%s", __func__);
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
     NSLog(@"%s", __func__);
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView{
     NSLog(@"%s", __func__);
}

#pragma mark - tapgesture 

- (void)mapviewTapped:(UITapGestureRecognizer*)gesture{
    CGPoint touchpoint = [gesture locationInView:self.mapview];
    
    CLLocationCoordinate2D coordinate = [self.mapview convertPoint:touchpoint toCoordinateFromView:self.mapview];
    
    __weak typeof(self) weakSelf = self;
    [self.geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"无法获取位置");
        }
        
        CLPlacemark *place = [placemarks lastObject];
        
        weakSelf.label.text = place.name;
    }
     ];
}
@end
