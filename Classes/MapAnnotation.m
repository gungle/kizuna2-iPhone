//
//  MapAnnotation.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

@synthesize annotationId;
@synthesize title;
@synthesize subtitle;
@synthesize posKind;
@synthesize posLat;
@synthesize posLon;
@synthesize coordinate;
@synthesize annotationType;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coord 
				   title:(NSString *)annTitle
				   subtitle:(NSString *)annSubtitle
		  annotationType:(MapAnnotationType)type {
	self = [super init];
	if (self != nil) {
		coordinate = coord;
		title = [annTitle retain];
		subtitle = [annSubtitle retain];
		annotationType = type;
	}
	return self;
}


-(void)setCoordinate{
	coordinate.latitude = [posLat doubleValue];	
	coordinate.longitude= [posLon doubleValue];	
}
-(void)setCoordinate:(CLLocationCoordinate2D)coordinateVal {
	coordinate = coordinateVal;
}


- (void)dealloc {
	[title   release];
	[subtitle   release];
	[posKind   release];
	[posLat    release];
	[posLon    release];
	[super     dealloc];
}

@end
