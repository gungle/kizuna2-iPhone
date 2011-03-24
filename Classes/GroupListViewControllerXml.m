//
//  GroupListViewControllerXml.m
//  Scope2
//	(1)平常時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/09.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "GroupListViewController.h"
#import "GroupsInfo.h"

@implementation GroupListViewController(Xml)

#pragma mark -
#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// indicator visible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
    if ([elementName isEqualToString:ELEMENT_NAME_GROUP]) {
		groupsInfo = [[GroupsInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {  
	
	if ([nodeName isEqualToString:ELEMENT_NAME_GROUPS] || [nodeName isEqualToString:ELEMENT_NAME_GROUP]) {
	} else {
		[nodeContent appendString:string];
	}
		
}
	
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
	// エレメント終了ハンドラ
	if (qualifiedName) {
		elementName = qualifiedName;
	}
	if ([elementName isEqualToString:ELEMENT_NAME_GROUP]) {
		[items addObject:groupsInfo];
		[groupsInfo release];
		groupsInfo = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_GROUPS]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				messages = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
				groupsInfo.groupId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]) {
				groupsInfo.groupName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]) {
				groupsInfo.familyNumber = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				groupsInfo.updatedAt = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
	[nodeName release];
	nodeName = nil;
}
	
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[self setDisasterInfoTab:[mode intValue]];
	if ([result isEqualToString:@"NG"]) {
		[self alertApiErrorMessageView];
	}
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}
	
	
@end
