//
//  ClassXMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "ClassXMLParser.h"
#import "UClassMng.h"

static ClassXMLParser *sharedClassXMLParser;

@implementation ClassXMLParser

@synthesize delegate;
@synthesize classMng;

+ (ClassXMLParser *)sharedXMLParser {
	if (!sharedClassXMLParser) {
		sharedClassXMLParser = [[ClassXMLParser alloc] init];
	}
	return sharedClassXMLParser;
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:sharedClassXMLParser];
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
//	[classMng release];
//	sharedClassXMLParser = nil;
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
    if ([elementName isEqualToString:@"group"]) {
		classMng = [[UClassMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:@"id"]
			|| [elementName isEqualToString:@"group_name"]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
#else
    if ([elementName isEqualToString:ELEMENT_NAME_CLASS]) {
		classMng = [[UClassMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_CLASS_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_CLASS_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]
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
	if ([nodeName isEqualToString:@"groups"] || [nodeName isEqualToString:@"group"]) {
/*
    if ([nodeName isEqualToString:ELEMENT_NAME_MODE]
		|| [nodeName isEqualToString:ELEMENT_NAME_RESULT]
		|| [nodeName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [nodeName isEqualToString:@"group_id"]
		|| [nodeName isEqualToString:@"group_name"]) {
		// エレメントの文字データを string で取得
		[nodeContent appendString:string];
	}
*/
#else
	if ([nodeName isEqualToString:ELEMENT_NAME_CLASSES] || [nodeName isEqualToString:ELEMENT_NAME_CLASS]) {
/*
    if ([nodeName isEqualToString:ELEMENT_NAME_MODE]
		|| [nodeName isEqualToString:ELEMENT_NAME_RESULT]
		|| [nodeName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [nodeName isEqualToString:ELEMENT_NAME_CLASS_ID]
		|| [nodeName isEqualToString:ELEMENT_NAME_CLASS_NAME]
		|| [nodeName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
		// エレメントの文字データを string で取得
		[nodeContent appendString:string];
	}
*/
#endif
	} else {
		[nodeContent appendString:string];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
{
    // エレメント終了ハンドラ
    if (qualifiedName) {
        elementName = qualifiedName;
    }
#if TARGET_IPHONE_SIMULATOR
    if ([elementName isEqualToString:@"group"]) {
		classMng.familyNumber = @"3";
		[items addObject:classMng];
		[classMng release];
		classMng = nil;
	} else {
		if ([elementName isEqualToString:@"groups"]) {
			mode = [[NSString alloc]initWithString:@"1"];			
		}else {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"id"]) {
				classMng.classId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"group_name"]) {
				classMng.className = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
#else
    if ([elementName isEqualToString:ELEMENT_NAME_CLASS]) {
		[items addObject:classMng];
		[classMng release];
		classMng = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_CLASSES]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_CLASS_ID]) {
				classMng.classId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_CLASS_NAME]) {
				classMng.className = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]) {
				classMng.familyNumber = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				classMng.updatedAt = [[NSString alloc]initWithString:nodeContent];
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
	[self.delegate classXmlDidFinishInitialize:self];
}

@end
