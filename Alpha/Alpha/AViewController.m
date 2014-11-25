//
//  AViewController.m
//  Alpha
//
//  Created by Brian Leppez on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "AViewController.h"
#import "AMapViewAnnotation.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self->mapView setShowsUserLocation:YES];
    annotations = [[NSMutableArray alloc]init];
    
    //initialize location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //[locationManager requestAlwaysAuthorization]; - throws an error
    [locationManager startUpdatingLocation];
    
    //set battery monitoring
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(batteryChanged:) name:UIDeviceBatteryLevelDidChangeNotification object:device];
}

- (void)viewWillAppear:(BOOL)animated{
    [self deleteAllPins];
    [annotations removeAllObjects];
    //Null check for default values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults stringForKey:@"username"] == nil) {
        [defaults setObject:@"Anonymous" forKey:@"username"];
    }
    if ([defaults stringForKey:@"groupName"] == nil) {
        [defaults setObject:@"RideHome" forKey:@"groupName"];
    }
    if ([defaults objectForKey:@"phoneNumber"] == nil) {
        [defaults setObject:[NSNumber numberWithInt:1234567890] forKey:@"phoneNumber"];
    }
    NSString *groupName = [defaults stringForKey:@"groupName"];
    [groupTitle setTitle:groupName];
    myRootRef = [[Firebase alloc] initWithUrl:@"https://cs378-ios.firebaseio.com"];
    [self.view addSubview:mapView];
    Firebase* myGroupRef = [myRootRef childByAppendingPath:groupName];
    [myGroupRef observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self createAnnotation:snapshot];
        NSLog(@"Number of Annotations: %lu", [annotations count]);
        [self->mapView showAnnotations:annotations animated:YES];
    }];
    [myGroupRef observeEventType:FEventTypeChildChanged withBlock:^(FDataSnapshot *snapshot) {
        [self updateAnnotation:snapshot];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* newLocation = [locations lastObject];
    NSString* lat = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    NSString* lon = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    NSString *groupName = [defaults stringForKey:@"groupName"];
    
    //reset screen title if necessary
    if (!([groupTitle.title isEqualToString:[defaults stringForKey:@"groupName"]]))
    {
        [groupTitle setTitle:groupName];
    }
    NSString *latPath = [NSString stringWithFormat:@"%@/%@/lat", groupName, username];
    NSString *lonPath = [NSString stringWithFormat:@"%@/%@/lon", groupName, username];
    [[myRootRef childByAppendingPath:latPath] setValue:lat];
    [[myRootRef childByAppendingPath:lonPath] setValue:lon];
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

-(void) createAnnotation:(FDataSnapshot*)snapshot{
    // Read locations from the locations property list
    NSDictionary* value = snapshot.value;
    NSString *title = snapshot.key;
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
    [self->mapView addAnnotation:point];
}

-(void) updateAnnotation:(FDataSnapshot*)snapshot{
    NSString *title = snapshot.key;
    NSNumber *latitude = [snapshot.value objectForKey:@"lat"];
    NSNumber *longitude = [snapshot.value objectForKey:@"lon"];
    CLLocationCoordinate2D coord;
    coord.latitude = latitude.doubleValue;
    coord.longitude = longitude.doubleValue;
    for (int i = 0; i < [annotations count]; i++) {
        MKPointAnnotation *point = [annotations objectAtIndex:i];
        if ([point.title isEqualToString:title]){
            point.coordinate = coord;
            break;
        }
    }
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
