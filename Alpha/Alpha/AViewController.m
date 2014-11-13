//
//  AViewController.m
//  Alpha
//
//  Created by Brian Leppez on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "AViewController.h"
#import "AMapViewAnnotation.h"
#import <Firebase/Firebase.h>

@interface AViewController ()

@end

@implementation AViewController
#define METERS_PER_MILE 1609.344


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set battery monitoring
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryChanged:) name:UIDeviceBatteryLevelDidChangeNotification object:device];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://cs378-ios.firebaseio.com"];
    [self.view addSubview:mapView];
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary* firebaseDict = snapshot.value;
        [self deleteAllPins];
        [self->mapView addAnnotations: [self createAnnotations:firebaseDict]];
    }];
    [mapView setDelegate:self];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.tintColor = [UIColor greenColor];
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
- (void)deleteAllPins{
    id userLocation = [mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[mapView annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    [mapView removeAnnotations:pins];
    pins = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    CLLocationCoordinate2D coord = {.latitude =  30.2669444, .longitude =  -97.7427778};
    
    MKCoordinateRegion viewRegion  = MKCoordinateRegionMakeWithDistance(coord, 7.5*METERS_PER_MILE,7.5*METERS_PER_MILE);
    
    [mapView setRegion:viewRegion animated:YES];

}

-(NSMutableArray *) createAnnotations:(NSDictionary*)json {
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    
    // Read locations from the locations property list
    
    for(id key in json) {
        NSDictionary* value = [json objectForKey:key];
        NSString *title = key;
        NSNumber *latitude = [value objectForKey:@"lat"];
        NSNumber *longitude = [value objectForKey:@"lon"];
        
        //Create coordinates from the latitude and longitude values
        CLLocationCoordinate2D coord;
        coord.latitude = latitude.doubleValue;
        coord.longitude = longitude.doubleValue;
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coord;
        point.title = title;
        [annotations addObject:point];
    }
    return annotations;
    
}



- (void)zoomToLocation
{
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 30.2669444;
    zoomLocation.longitude= -97.7427778;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 7.5*METERS_PER_MILE,7.5*METERS_PER_MILE);
    [mapView setRegion:viewRegion animated:YES];
    
    [mapView regionThatFits:viewRegion];
}

- (NSNumber *)getBatteryLevel
{
    UIDevice *device = [UIDevice currentDevice];
    return [NSNumber numberWithFloat:device.batteryLevel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
