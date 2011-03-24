//
//  GroupsInfo.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "GroupsInfo.h"


@implementation GroupsInfo

@synthesize groupId;
@synthesize groupName;
@synthesize updatedAt;
@synthesize familyNumber;

- (void)dealloc {
	[groupId      release];
	[groupName    release];
	[updatedAt    release];
	[familyNumber release];
	[super        dealloc];
}

@end
