//
//  AViewController.h
//  Alpha
//
//  Created by Brian Leppez on 10/14/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

@interface AViewController : UIViewController {

    MKMapView *mapView;
    NSDictionary *friends;
}

@end
