//
//  PersonalInfoXMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/08.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalInfoXMLParser.h"
#import "UPersonalMng.h"

static PersonalInfoXMLParser *sharedPersonalInfoXMLParser;

@implementation PersonalInfoXMLParser

+ (PersonalInfoXMLParser *)sharedPersonalInfoXMLParser {
	if (!sharedPersonalInfoXMLParser) {
		NSLog(@"----- >>>>>>>>>>>>>> PersonalInfoXMLParser");
		sharedPersonalInfoXMLParser = [[PersonalInfoXMLParser alloc] init];
	}
	return sharedPersonalInfoXMLParser;
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:sharedPersonalInfoXMLParser];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
		NSLog(@"error %@",parseError);
	}
	[parser release];
	
}

- (void)dealloc {
	NSLog(@"----- >>>>>>>>>>>>>> dealloc");
	sharedPersonalInfoXMLParser = nil;
    [super   dealloc];
	NSLog(@"----- >>>>>>>>>>>>>> dealloc");
}

@end