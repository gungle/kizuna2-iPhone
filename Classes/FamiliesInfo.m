//
//  FamiliesInfo.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "FamiliesInfo.h"


@implementation FamiliesInfo

@synthesize familyId;
@synthesize familyName;
@synthesize address;
@synthesize homeTel;
@synthesize homeLat;
@synthesize homeLon;
@synthesize weakKind;
@synthesize personNum;

- (void)dealloc {
	[familyId      release];
	[familyName    release];
	[address       release];
	[homeTel       release];
	[homeLat       release];
	[homeLon       release];
	[weakKind      release];
	[personNum     release];
	[super         dealloc];
}

@end
