//
//  DisasterData.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright 2010 Institute for HyperNetwork Society. All rights reserved.
//

#import "DisasterData.h"


@implementation DisasterData

@synthesize sectionKind;
@synthesize subItems;

- (id)init {
	if (self = [super init]) {
		subItems = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

- (void)dealloc {
	[sectionKind     release];
	[subItems        release];
	[super           dealloc];
}
@end
