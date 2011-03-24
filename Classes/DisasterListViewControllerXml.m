//
//  DisasterListViewControllerXml.m
//  Scope2
//	(11)災害時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/10.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterListViewController.h"



@implementation DisasterListViewController(Xml)

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
	
	if ([elementName isEqualToString:ELEMENT_NAME_GROUP]) {
	} else if ([elementName isEqualToString:ELEMENT_NAME_SAFETIES]
			   || [elementName isEqualToString:ELEMENT_NAME_HELPS]
			   || [elementName isEqualToString:ELEMENT_NAME_WEAKS]) {
		disasterData = [[DisasterData alloc] init];	
		if ([elementName isEqualToString:ELEMENT_NAME_SAFETIES]) {
			disasterData.sectionKind = @"0";
		} else if ([elementName isEqualToString:ELEMENT_NAME_HELPS]) {
			disasterData.sectionKind = @"1";
		} else if ([elementName isEqualToString:ELEMENT_NAME_WEAKS]) {
			disasterData.sectionKind = @"2";
		}
	} else if ([elementName isEqualToString:ELEMENT_NAME_SAFETY]
			   || [elementName isEqualToString:ELEMENT_NAME_HELP]
			   || [elementName isEqualToString:ELEMENT_NAME_WEAK]) {
//		NSLog(@">>>> start element %@",elementName);
		disastersInfo = [[DisastersInfo alloc] init];
		if ([elementName isEqualToString:ELEMENT_NAME_SAFETY]) {
//			NSLog(@">>>> safety mode %@",[attributeDict objectForKey:ATTRIBUTE_NAME_MODE]);
			disastersInfo.safetyMode = [[NSString alloc]initWithString:[attributeDict objectForKey:ATTRIBUTE_NAME_MODE]];
		}
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULTS]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FULL_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_AGE]
			|| [elementName isEqualToString:ELEMENT_NAME_SEX]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_SAFETY_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]
			|| [elementName isEqualToString:ELEMENT_NAME_TRIAGE_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_STATUS]
			|| [elementName isEqualToString:ELEMENT_NAME_EMERGENCY_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_DISASTER_STATUS_KIND]
			|| [elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]
			|| [elementName isEqualToString:ELEMENT_NAME_DONE_KIND]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
	if ([nodeName isEqualToString:ELEMENT_NAME_GROUPS]
		|| [nodeName isEqualToString:ELEMENT_NAME_GROUP]
		|| [nodeName isEqualToString:ELEMENT_NAME_SAFETIES]
		|| [nodeName isEqualToString:ELEMENT_NAME_HELPS]
		|| [nodeName isEqualToString:ELEMENT_NAME_WEAKS]
		|| [nodeName isEqualToString:ELEMENT_NAME_SAFETY]
		|| [nodeName isEqualToString:ELEMENT_NAME_HELP]
		|| [nodeName isEqualToString:ELEMENT_NAME_WEAK]) {
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
	
	if ([elementName isEqualToString:ELEMENT_NAME_GROUP]) {
		[xmlGroupId release];
		xmlGroupId = nil;
		[xmlGroupName release];
		xmlGroupName = nil;
	} else if ([elementName isEqualToString:ELEMENT_NAME_SAFETIES]
			   || [elementName isEqualToString:ELEMENT_NAME_HELPS]
			   || [elementName isEqualToString:ELEMENT_NAME_WEAKS]) {
		disasterData.groupId = [[NSString alloc]initWithString:xmlGroupId];
		disasterData.groupName = [[NSString alloc]initWithString:xmlGroupName];
		[items addObject:disasterData];
		[disasterData release];
		disasterData = nil;
	} else if ([elementName isEqualToString:ELEMENT_NAME_SAFETY]
			   || [elementName isEqualToString:ELEMENT_NAME_HELP]
			   || [elementName isEqualToString:ELEMENT_NAME_WEAK]){
		[disasterData.subItems addObject:disastersInfo];
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
		} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
			xmlGroupId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_NAME]) {
			xmlGroupName = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
			disastersInfo.personalId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_FULL_NAME]) {
			disastersInfo.fullName = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_AGE]) {
			disastersInfo.age = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_SEX]) {
			disastersInfo.sex = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_SAFETY_KIND]) {
			disastersInfo.personalSafetyKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
			disastersInfo.familyId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]) {
			disastersInfo.familyName = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_EMERGENCY_KIND]) {
			disastersInfo.emergencyKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_STATUS]) {
			disastersInfo.status = [[NSString alloc]initWithString:nodeContent];
		}else if ([elementName isEqualToString:ELEMENT_NAME_DISASTER_STATUS_KIND]) {
			disastersInfo.disasterStatusKind = [[NSString alloc]initWithString:nodeContent];
		}else if ([elementName isEqualToString:ELEMENT_NAME_DISASTER_MEMO]) {
			disastersInfo.disasterMemo = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_TRIAGE_KIND]) {
			disastersInfo.triageKind = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_DONE_KIND]) {
			disastersInfo.doneKind = [[NSString alloc]initWithString:nodeContent];
			
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
	
	if ([result isEqualToString:@"NG"] || messages != nil || [messages isEqualToString:@""]) {
		[self alertApiErrorMessageView];
	}
	
	tblView.scrollEnabled = YES;
	
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

@end
