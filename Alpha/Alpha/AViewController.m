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
	// Do any additional setup after loading the view, typically from a nib.
//    CLLocationCoordinate2D coord = {.latitude =  30.2669444, .longitude =  -97.7427778};
//    MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
//    MKCoordinateRegion region = {coord, span};
    
//    [mapView setRegion:region];
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://cs378-ios.firebaseio.com"];
    [self.view addSubview:mapView];
    [myRootRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSDictionary* firebaseDict = snapshot.value;
        [self->mapView addAnnotations: [self createAnnotations:firebaseDict]];
        //NSDictionary* foo = [firebaseDict objectForKey:@"samallen"];
        //NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
