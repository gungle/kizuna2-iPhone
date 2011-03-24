    //
//  PersonalXMLParserViewController.h.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalXMLParserViewController.h"
#import "PersonalsInfo.h"


@implementation PersonalXMLParserViewController


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
	
    if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		personalsInfo = [[PersonalsInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULTS]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_FULL_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_ADDRESS]
			|| [elementName isEqualToString:ELEMENT_NAME_AGE]
			|| [elementName isEqualToString:ELEMENT_NAME_BLOOD]
			|| [elementName isEqualToString:ELEMENT_NAME_SEX]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_TEL]
			|| [elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_JOB]
			|| [elementName isEqualToString:ELEMENT_NAME_GOOD_FIELD]
			|| [elementName isEqualToString:ELEMENT_NAME_MEDICAL_HISTORY]
			|| [elementName isEqualToString:ELEMENT_NAME_ICON_PATH]
			|| [elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]
			|| [elementName isEqualToString:ELEMENT_NAME_ACCESS_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
	if ([nodeName isEqualToString:ELEMENT_NAME_PERSONALS] || [nodeName isEqualToString:ELEMENT_NAME_PERSONAL]) {
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
	if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		[items addObject:personalsInfo];
		[personalsInfo release];
		personalsInfo = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_PERSONALS]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];	
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULTS]) {
				results = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				messages = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
				personalsInfo.personalId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
				personalsInfo.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]) {
				personalsInfo.familyName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FULL_NAME]) {
				personalsInfo.fullName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ADDRESS]) {
				personalsInfo.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_AGE]) {
				personalsInfo.age = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_BLOOD]) {
				personalsInfo.blood = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_SEX]) {
				personalsInfo.sex = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_TEL]) {
				personalsInfo.personalTel = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]) {
				personalsInfo.weakKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_JOB]) {
				personalsInfo.job = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GOOD_FIELD]) {
				personalsInfo.goodField = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_MEDICAL_HISTORY]) {
				personalsInfo.medicalHistory = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ICON_PATH]) {
				personalsInfo.iconPath = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]) {
				personalsInfo.disasterMemo = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ACCESS_KIND]) {
				personalsInfo.accessKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				personalsInfo.updatedAt = [[NSString alloc]initWithString:nodeContent];
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
	if ([result isEqualToString:@"NG"]) {
		[self alertApiErrorMessageView];
	}
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

@end
