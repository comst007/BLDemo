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
    self.mapview.region = MKCoordinateRegionMake(self.mapview.userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    self.mapview.showsUserLocation = YES;
    self.mapview.showsBuildings = YES;
    self.mapview.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapview.mapType = MKMapTypeStandard;
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapviewTapped:)];
    tapgesture.numberOfTapsRequired = 1;
    
    //[self.mapview addGestureRecognizer:tapgesture];
    //114.046138,22.675652
    CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(22.675652, 114.046138);
    LZAnnotation *annotaion1 = [[LZAnnotation alloc]  initWithCoordinate:coordinate1 andTitle:@"111111" andSubtitle:@"222222222"];
    [self.mapview addAnnotation:annotaion1];
    
    //114.046556,22.676015
    CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(22.676015, 114.046556);
    LZAnnotation *annotaion2 = [[LZAnnotation alloc]  initWithCoordinate:coordinate2 andTitle:@"aaaaaaa" andSubtitle:@"bbbbbbbbbbbbb"];
    [self.mapview addAnnotation:annotaion2];
    
    //114.045415,22.675343
    CLLocationCoordinate2D coordinate3 = CLLocationCoordinate2DMake(22.675343, 114.045415);
    LZAnnotation *annotaion3 = [[LZAnnotation alloc]  initWithCoordinate:coordinate3 andTitle:@"+++++++++" andSubtitle:@"**********"];
    [self.mapview addAnnotation:annotaion3];
    
    //[self.mapview showAnnotations:self.mapview.annotations animated:YES];
    
    [self startnavigation2];
    
    
    
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
    NSLog(@"floor: %li", (long)currentlocation.floor.level);
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *annotationview ;
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    annotationview = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LZAnnotationView"];
    
    if (annotationview == nil) {
        annotationview = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@"LZAnnotaionView"];
        annotationview.canShowCallout = YES;
        annotationview.pinColor = MKPinAnnotationColorPurple;
        annotationview.animatesDrop = YES;
        UIView *leftview = [[UIView alloc] init];
        leftview.frame = CGRectMake(0, 0, 30, 30);
        leftview.backgroundColor = [UIColor redColor];
        annotationview.leftCalloutAccessoryView = leftview;
        
        UIView *rightview = [[UIView alloc] init];
        rightview.backgroundColor = [UIColor greenColor];
        rightview.frame = CGRectMake(0, 0, 30, 30);
        annotationview.rightCalloutAccessoryView = rightview;
    }
    annotationview.annotation = annotation;
    return annotationview;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
  NSLog(@"%s", __func__);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *linerender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    linerender.lineCap = kCGLineCapRound;
    linerender.lineJoin = kCGLineJoinRound;
    linerender.lineWidth = 5;
    linerender.strokeColor = [UIColor blueColor];
    
    return linerender;
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
        LZAnnotation *newAnnotation = [[LZAnnotation alloc] initWithCoordinate:coordinate andTitle:place.locality andSubtitle:place.name];
        
        [weakSelf.mapview addAnnotation:newAnnotation];
        [weakSelf.mapview showAnnotations:weakSelf.mapview.annotations animated:YES];
    }
     ];
}

#pragma mark -- navigation

- (void)startNavigation1{
    
    NSString *start = @"深圳市";
    NSString *destination = @"广州市";
    
    __block MKMapItem *sourceItem;
    
    __block MKMapItem *destItem;
    
    __block MKPlacemark *startPlacemark;
    __block MKPlacemark *destPlacemark;
    
    __weak typeof(self) weakself = self;
    
    [weakself.geocoder geocodeAddressString:start completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks firstObject];
        startPlacemark = [[MKPlacemark alloc] initWithPlacemark:place];
        
        
        
        [weakself.geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *place = [placemarks firstObject];
            destPlacemark = [[MKPlacemark alloc] initWithPlacemark:place];
            
            MKDirectionsRequest *directionrequest;
            directionrequest = [[MKDirectionsRequest alloc] init];
            
            sourceItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
            destItem = [[MKMapItem alloc] initWithPlacemark:destPlacemark];
            
            directionrequest.source = sourceItem;
            directionrequest.destination = destItem;
            directionrequest.requestsAlternateRoutes = NO;
            directionrequest.transportType = MKDirectionsTransportTypeAutomobile;
            
            MKDirections *directions = [[MKDirections alloc]  initWithRequest:directionrequest];
            
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                
                if (error) {
                    NSLog(@"---%@---", [error localizedDescription]);
                    return ;
                }
                MKRoute *route = [response.routes firstObject];
                NSLog(@"%@", route.name);
                NSLog(@"%lf", route.distance);
                NSLog(@"%lf", route.expectedTravelTime);
                NSLog(@"%lu", (unsigned long)route.transportType);
                
                [weakself.mapview addOverlay:route.polyline];
            }];

        }];
        
        
        
    }];
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        
//        
//    });
    
//    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
//        [weakself.geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
//            CLPlacemark *place = [placemarks firstObject];
//            destPlacemark = [[MKPlacemark alloc] initWithPlacemark:place];
//        }];
//        
//    });
    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        
//        
//    });
    
    
    
    
    
}

- (void) startnavigation2{
    NSString *start = @"深圳市";
    NSString *destination = @"广州市";
    
    __block MKMapItem *sourceItem;
    
    __block MKMapItem *destItem;
    
    __block MKPlacemark *startPlacemark;
    __block MKPlacemark *destPlacemark;
    
    __weak typeof(self) weakself = self;
    
    [weakself.geocoder geocodeAddressString:start completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks firstObject];
        startPlacemark = [[MKPlacemark alloc] initWithPlacemark:place];
        
        
        
        [weakself.geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *place = [placemarks firstObject];
            destPlacemark = [[MKPlacemark alloc] initWithPlacemark:place];
            
            MKDirectionsRequest *directionrequest;
            directionrequest = [[MKDirectionsRequest alloc] init];
            
            sourceItem = [[MKMapItem alloc] initWithPlacemark:startPlacemark];
            destItem = [[MKMapItem alloc] initWithPlacemark:destPlacemark];
            
            NSArray *itemArray = @[sourceItem, destItem];
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            
            dic[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
            dic[MKLaunchOptionsMapTypeKey] = @(MKMapTypeStandard);
            dic[MKLaunchOptionsShowsTrafficKey] = @(YES);
            dic[MKLaunchOptionsMapSpanKey] = [NSValue valueWithMKCoordinateSpan:MKCoordinateSpanMake(0.5, 0.5)];
            
            [MKMapItem openMapsWithItems:itemArray launchOptions:dic];
            
        }];
        
        
        
    }];
}
@end
