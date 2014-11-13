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
@synthesize title=_name;
-(id) initWithTitle:(NSString *)title AndCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    title = title;
    coordinate = coordinate;
    return self;
}



@end
