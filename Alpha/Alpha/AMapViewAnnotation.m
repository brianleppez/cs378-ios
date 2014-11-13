//
//  AMapViewAnnotation.m
//  Alpha
//
//  Created by Brian Leppez on 11/11/14.
//  Copyright (c) 2014 cs378. All rights reserved.
//

#import "AMapViewAnnotation.h"

@implementation AMapViewAnnotation

@synthesize coordinate=_coordinate;
@synthesize name=_name;
-(id) initWithName:(NSString *)name AndCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    _name = name;
    _coordinate = coordinate;
    return self;
}



@end
