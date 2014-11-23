//
//  AViewController.h
//  Alpha
//
//  Created by Brian Leppez on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Firebase/Firebase.h>

@interface AViewController : UIViewController <CLLocationManagerDelegate>{
    __weak IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    Firebase* myRootRef;
    __weak IBOutlet UINavigationItem *groupTitle;
}
@end
