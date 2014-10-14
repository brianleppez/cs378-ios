//
//  AViewController.m
//  Alpha
//
//  Created by Brian Leppez on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeStandard;
    
    
    CLLocationCoordinate2D coord = {.latitude =  30.2669444, .longitude =  -97.7427778};
    MKCoordinateSpan span = {.latitudeDelta =  0.2, .longitudeDelta =  0.2};
    MKCoordinateRegion region = {coord, span};
    
    [mapView setRegion:region];
    [self.view addSubview:mapView];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
