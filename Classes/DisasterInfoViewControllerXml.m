//
//  DisasterInfoViewControllerXml.m
//  Scope2
//	(12)災害情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/13.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterInfoViewController.h"
#import "DisastersInfo.h"

@implementation DisasterInfoViewController(Xml)


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
	if (qualifiedName) {
        elementName = qualifiedName;
    }
	
	if ([elementName isEqualToString:ELEMENT_NAME_DISASTER]) {
	} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		disastersInfo = [[DisastersInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULTS]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FULL_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_AGE]
			|| [elementName isEqualToString:ELEMENT_NAME_SEX]
			|| [elementName isEqualToString:ELEMENT_NAME_TRIAGE_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_EMERGENCY_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_DISASTER_STATUS_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]
			|| [elementName isEqualToString:ELEMENT_NAME_DONE_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_PICTURE_PATH]
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
	if ([nodeName isEqualToString:ELEMENT_NAME_DISASTER]
		|| [nodeName isEqualToString:ELEMENT_NAME_PERSONAL]) {
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
	
	if ([elementName isEqualToString:ELEMENT_NAME_DISASTER]) {
	} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		[items addObject:disastersInfo];
		[disastersInfo release];
		disastersInfo = nil;
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			mode = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
			result = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_RESULTS]) {
			results = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
			messages = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
			disastersInfo.personalId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_FULL_NAME]) {
			disastersInfo.fullName = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_AGE]) {
			disastersInfo.age = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_SEX]) {
			disastersInfo.sex = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_EMERGENCY_KIND]) {
			disastersInfo.emergencyKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_DISASTER_STATUS_KIND]) {
			disastersInfo.disasterStatusKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]) {
			disastersInfo.disasterMemo = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_TRIAGE_KIND]) {
			disastersInfo.triageKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_DONE_KIND]) {
			disastersInfo.doneKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PICTURE_PATH]) {
			disastersInfo.picturePath = [[NSString alloc]initWithString:nodeContent];
		}
		[nodeContent release];
		nodeContent = nil;
	}
	
	[nodeName release];
	nodeName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	// 解析終了時に実行する処理
	// 災害時はタブを減らさない
	//	[self setDisasterInfoTab:[mode intValue]];
	if ([result isEqualToString:@"NG"]) {
		[self alertApiErrorMessageView];
	}
	
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

@end

