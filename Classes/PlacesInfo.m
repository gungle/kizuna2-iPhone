//
//  PlacesInfo.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PlacesInfo.h"


@implementation PlacesInfo

@synthesize placeId;
@synthesize placeKind;
@synthesize placeTitle;
@synthesize placeExplain;
@synthesize placeLat;
@synthesize placeLon;
@synthesize picturePath;
@synthesize mapTitle;
@synthesize nowLocation;

- (void)dealloc {
	[placeId      release];
	[placeKind    release];
	[placeTitle   release];
	[placeExplain release];
	[placeLat     release];
	[placeLon     release];
	[picturePath  release];
	[mapTitle     release];
	[super        dealloc];
}

- (CLLocationCoordinate2D)getNowCoordinate {
	double latitude  = [placeLat doubleValue];
	double longitude = [placeLon doubleValue];
	CLLocationCoordinate2D loc;
	loc.latitude = latitude;
	loc.longitude = longitude;
	
	return loc;
}

@end
