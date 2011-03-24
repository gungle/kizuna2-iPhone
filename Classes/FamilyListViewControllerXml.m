//
//  FamilyListViewControllerXml.m
//  Scope2
//	(2)世帯一覧画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/09.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "FamilyListViewController.h"
#import "FamiliesInfo.h"

@implementation FamilyListViewController(Xml)

#pragma mark -
#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// indicator visible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
    if ([elementName isEqualToString:ELEMENT_NAME_FAMILY]) {
		familiesInfo = [[FamiliesInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]
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
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if ([nodeName isEqualToString:ELEMENT_NAME_FAMILIES] || [nodeName isEqualToString:ELEMENT_NAME_FAMILY]) {
	} else {
		[nodeContent appendString:string];
	}
}
															 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
//	NSLog(@"%@ = %@",elementName,nodeContent);
	// エレメント終了ハンドラ
	if (qualifiedName) {
		elementName = qualifiedName;
	}
	if ([elementName isEqualToString:ELEMENT_NAME_FAMILY]) {
		[items addObject:familiesInfo];
		[familiesInfo release];
		familiesInfo = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_FAMILIES]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				messages = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
				familiesInfo.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
				familiesInfo.groupId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]) {
				familiesInfo.groupName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]) {
				familiesInfo.familyName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NUMBER]) {
				familiesInfo.familyNumber = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ADDRESS]) {
				familiesInfo.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_TEL]) {
				familiesInfo.homeTel = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_LAT]) {
				familiesInfo.homeLat = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_HOME_LON]) {
				familiesInfo.homeLon = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]) {
				familiesInfo.weakKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				familiesInfo.updatedAt = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
	[nodeName release];
	nodeName = nil;
}
		 
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	// 解析終了時に実行する処理
	[self setDisasterInfoTab:[mode intValue]];
	if ([result isEqualToString:@"NG"] || messages != nil || [messages isEqualToString:@""]) {
		[self alertApiErrorMessageView];
	}
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
