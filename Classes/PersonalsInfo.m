//
//  PersonalsInfo.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalsInfo.h"


@implementation PersonalsInfo

@synthesize personalId;
@synthesize login;
@synthesize password;
@synthesize fullName;
@synthesize birthday;
@synthesize sex;
@synthesize blood;
@synthesize personalTel;
@synthesize job;
@synthesize goodField;
@synthesize medicalHistory;
@synthesize iconPath;
@synthesize age;
@synthesize disasterMemo;
@synthesize accessKind;

- (void)dealloc {
	[personalId     release];
	[login          release];
	[password       release];
	[fullName       release];
	[birthday       release];
	[sex            release];
	[blood          release];
	[personalTel    release];
	[job            release];
	[goodField      release];
	[medicalHistory release];
	[iconPath       release];
	[age            release];
	[disasterMemo   release];
	[accessKind     release];
	[super          dealloc];
}

@end
