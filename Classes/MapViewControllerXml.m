//
//  MapViewControllerXml.m
//  Scope2
//	(21)地図画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "MapViewController.h"
#import "PlacesInfo.h"

@implementation MapViewController(Xml)

#pragma mark -
#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// indicator visible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//	items = [[NSMutableArray alloc] initWithCapacity:0];
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
//	NSLog(@"start element %@",elementName);
	if (qualifiedName) {
        elementName = qualifiedName;
    }
	
    if ([elementName isEqualToString:ELEMENT_NAME_PLACE]) {
		placesInfo = [[PlacesInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_TITLE]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_EXPLAIN]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_LAT]
			|| [elementName isEqualToString:ELEMENT_NAME_PLACE_LON]
			|| [elementName isEqualToString:ELEMENT_NAME_PICTURE_PATH]
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
	if ([nodeName isEqualToString:ELEMENT_NAME_PLACES] || [nodeName isEqualToString:ELEMENT_NAME_PLACE]) {
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
	if ([elementName isEqualToString:ELEMENT_NAME_PLACE]) {
		[mapInfoArray addObject:placesInfo];
		[placesInfo release];
		placesInfo = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_PLACES]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				messages = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_ID]) {
				placesInfo.placeId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
				placesInfo.groupId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_TITLE]) {
				placesInfo.placeTitle = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_EXPLAIN]) {
				placesInfo.placeExplain = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_KIND]) {
				placesInfo.placeKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_LAT]) {
				placesInfo.placeLat = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PLACE_LON]) {
				placesInfo.placeLon = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PICTURE_PATH]) {
				placesInfo.picturePath = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				placesInfo.updatedAt = [[NSString alloc]initWithString:nodeContent];
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
	// 災害時はタブを減らさない
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	if ([scope2Delegate.tabBarController selectedIndex] == 0) {
		// 通常時モードの場合
		[self setDisasterInfoTab:[mode intValue]];
	}
	
	if ([result isEqualToString:@"NG"] || messages != nil || [messages isEqualToString:@""]) {
		[self alertApiErrorMessageView];
	}
	[self displayAnnotations];
	
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

@end
