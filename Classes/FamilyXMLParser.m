//
//  FamilyXMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "FamilyXMLParser.h"
#import "UFamilyMng.h"

static FamilyXMLParser *sharedFamilyXMLParser;


@implementation FamilyXMLParser

@synthesize delegate;
@synthesize familyMng;

+ (FamilyXMLParser *)sharedXMLParser {
	NSLog(@"----- >>>>>>>>>>>>>> FamilyXMLParser");
	if (!sharedFamilyXMLParser) {
		NSLog(@"----- >>>>>>>>>>>>>> A");
		sharedFamilyXMLParser = [[FamilyXMLParser alloc] init];
	}
	NSLog(@"----- >>>>>>>>>>>>>> B");
	return sharedFamilyXMLParser;
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:sharedFamilyXMLParser];
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
//	sharedFamilyXMLParser = nil;
//	[familyMng release];
	[items removeAllObjects];
	[items release];
    [super   dealloc];
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
#if TARGET_IPHONE_SIMULATOR
    if ([elementName isEqualToString:@"family"]) {
		familyMng = [[UFamilyMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:@"id"]
			|| [elementName isEqualToString:@"group_id"]
			|| [elementName isEqualToString:@"family_name"]
			|| [elementName isEqualToString:@"user_id"]
			|| [elementName isEqualToString:@"address"]
			|| [elementName isEqualToString:@"tel"]
			|| [elementName isEqualToString:@"fax"]
			|| [elementName isEqualToString:@"home_lat"]
			|| [elementName isEqualToString:@"home_lon"]
			|| [elementName isEqualToString:@"icon_path"]
			|| [elementName isEqualToString:@"created_at"]
			|| [elementName isEqualToString:@"updated_at"]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
#else
    if ([elementName isEqualToString:ELEMENT_NAME_CLASS]) {
		familyMng = [[familyMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_CLASS_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_CLASS_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]
			|| [elementName isEqualToString:ELEMENT_NAME_ADDRESS]
			|| [elementName isEqualToString:ELEMENT_NAME_HOME_TEL]
			|| [elementName isEqualToString:ELEMENT_NAME_HOME_LAT]
			|| [elementName isEqualToString:ELEMENT_NAME_HOME_LON]
			|| [elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
	
#endif
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{
#if TARGET_IPHONE_SIMULATOR
	if ([nodeName isEqualToString:@"families"] || [nodeName isEqualToString:@"family"]) {
	} else {
		[nodeContent appendString:string];
	}
#else
	if ([nodeName isEqualToString:ELEMENT_NAME_FAMILIES] || [nodeName isEqualToString:ELEMENT_NAME_FAMILY) {
	} else {
		[nodeContent appendString:string];
	}
#endif															 
}
																 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
{
	// エレメント終了ハンドラ
	if (qualifiedName) {
		elementName = qualifiedName;
	}
#if TARGET_IPHONE_SIMULATOR
	if ([elementName isEqualToString:@"family"]) {
		familyMng.personNum = [[NSString alloc]initWithString:@"3"];
		familyMng.weakKind = [[NSString alloc]initWithString:@"1"];
		[items addObject:familyMng];
		[familyMng release];
		familyMng = nil;
	} else {
		if ([elementName isEqualToString:@"families"]) {
			mode = [[NSString alloc]initWithString:@"1"];			
		}else {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"id"]) {
				familyMng.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"group_name"]) {
				familyMng.className = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"family_name"]) {
				familyMng.familyName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"group_id"]) {
				familyMng.classId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"address"]) {
				familyMng.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"tel"]) {
				familyMng.homeTel = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
#else
	if ([elementName isEqualToString:ELEMENT_NAME_FAMILY) {
		[items addObject:familyMng];
		[familyMng release];
		familyMng = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_FAMILIES]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
				familyMng.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_CLASS_ID]) {
				familyMng.classId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_CLASS_NAME]) {
				familyMng.className = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]) {
				familyMng.familyName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]) {
				familyMng.familyNumber = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ADDRESS]) {
				familyMng.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_TEL]) {
				familyMng.homeTel = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_LAT]) {
				familyMng.homeLat = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_LON]) {
				familyMng.homeLon = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]) {
				familyMng.weakKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				familyMng.updatedAt = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
#endif
	[nodeName release];
	nodeName = nil;
}
		 
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	// 解析終了時に実行する処理
	[self.delegate familyXmlDidFinishInitialize:self];
}

@end
