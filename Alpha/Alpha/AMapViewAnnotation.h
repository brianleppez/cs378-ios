//
//  AMapViewAnnotation.h
//  Alpha
//
//  Created by Brian Leppez on 11/11/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>


@interface AMapViewAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;



-(id) initWithName:(NSString *)name AndCoordinate:(CLLocationCoordinate2D)coordinate;
@end