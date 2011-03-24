//
//  DisastersInfo.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisastersInfo.h"


@implementation DisastersInfo

@synthesize emergencyKind;
@synthesize disasterStatusKind;
@synthesize triageKind;
@synthesize doneKind;
@synthesize nowLat;
@synthesize nowLon;
@synthesize picturePath;
@synthesize personalSafetyKind;
@synthesize status;
@synthesize safetyMode;

- (void)dealloc {
	[emergencyKind      release];
	[disasterStatusKind release];
	[triageKind         release];
	[doneKind           release];
	[nowLat             release];
	[nowLon             release];
	[picturePath        release];
	[personalSafetyKind release];
	[status             release];
	[safetyMode         release];
	[super              dealloc];
}

@end
