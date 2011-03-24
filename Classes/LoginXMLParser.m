//
//  LoginXMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "LoginXMLParser.h"

static LoginXMLParser *sharedLoginXMLParser;

@implementation LoginXMLParser

@synthesize delegate;
@synthesize classId;
@synthesize personalId;

+ (LoginXMLParser *)sharedXMLParser {
	if (!sharedLoginXMLParser) {
		sharedLoginXMLParser = [[LoginXMLParser alloc] init];
	}
	return sharedLoginXMLParser;
}


- (void)dealloc {
	[classId release];
	[personalId  release];
	sharedLoginXMLParser = nil;
    [super   dealloc];
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:sharedLoginXMLParser];
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

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	NSLog(@"login parser didStartElement");
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
#if TARGET_IPHONE_SIMULATOR
    if ([elementName isEqualToString:ELEMENT_NAME_MODE]
		|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
		|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [elementName isEqualToString:@"group_id"]
		|| [elementName isEqualToString:@"user_id"]) {
		nodeContent = [[NSMutableString alloc] initWithCapacity:0];
	}
#else
    if ([elementName isEqualToString:ELEMENT_NAME_MODE]
		|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
		|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
		|| [elementName isEqualToString:ELEMENT_NAME_CLASS_ID]) {
		nodeContent = [[NSMutableString alloc] initWithCapacity:0];
	}
#endif
	nodeName = [elementName copy];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{  
	NSLog(@"login parser foundCharacters");
#if TARGET_IPHONE_SIMULATOR
    if ([nodeName isEqualToString:ELEMENT_NAME_MODE]
		|| [nodeName isEqualToString:ELEMENT_NAME_RESULT]
		|| [nodeName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [nodeName isEqualToString:@"group_id"]
		|| [nodeName isEqualToString:@"user_id"]) {
		// エレメントの文字データを string で取得
		[nodeContent appendString:string];
	}
#else
    if ([nodeName isEqualToString:ELEMENT_NAME_MODE]
		|| [nodeName isEqualToString:ELEMENT_NAME_RESULT]
		|| [nodeName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [nodeName isEqualToString:ELEMENT_NAME_CLASS_ID]
		|| [nodeName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
		// エレメントの文字データを string で取得
		[nodeContent appendString:string];
	}
#endif
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
{
	NSLog(@"login parser didEndElement");
    // エレメント終了ハンドラ
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
#if TARGET_IPHONE_SIMULATOR
	if (![elementName isEqualToString:ELEMENT_NAME_LOGIN]
		&& ![elementName isEqualToString:@"user"]) {
		
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
		} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
			result = [[NSString alloc]initWithString:nodeContent];			
		} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
			// エラーの場合
			message = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:@"group_id"]) {
			classId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:@"user_id"]) {
			personalId = [[NSString alloc]initWithString:nodeContent];
		}
		mode = [[NSString alloc]initWithString:@"1"];			
		[nodeContent release];
		nodeContent = nil;
	}
#else
	if (![elementName isEqualToString:ELEMENT_NAME_LOGIN]
		&& ![elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			mode = [[NSString alloc]initWithString:nodeContent];			
		} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
			result = [[NSString alloc]initWithString:nodeContent];			
		} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
			// エラーの場合
			message = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_CLASS_ID]) {
			classId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
			personalId = [[NSString alloc]initWithString:nodeContent];
		}
		[nodeContent release];
		nodeContent = nil;
	}
#endif
	[nodeName release];
	nodeName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	// 解析終了時に実行する処理
	NSLog(@"login parserDidEndDocument");
	[self.delegate loginXmlDidFinishInitialize:self];
	
}

@end
