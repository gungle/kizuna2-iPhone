//
//  PersonalListViewControllerXml.m
//  Scope2
//	(4)個人情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/09.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalListViewController.h"
#import "PersonalsInfo.h"

@implementation PersonalListViewController(Xml)

#pragma mark -
#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
	// indicator visible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	items = [[NSMutableArray alloc] initWithCapacity:0];
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
//	NSLog(@"start element %@",elementName);
	if (qualifiedName) {
        elementName = qualifiedName;
    }
	
//#if TARGET_IPHONE_SIMULATOR
//    if ([elementName isEqualToString:@"user"]) {
//		personalsInfo = [[PersonalsInfo alloc] init];
//	} else {
//		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
//			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
//			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
//			|| [elementName isEqualToString:@"id"]
//			|| [elementName isEqualToString:@"family_id"]
//			|| [elementName isEqualToString:@"full_name"]
//			|| [elementName isEqualToString:@"full_name_kana"]
//			|| [elementName isEqualToString:@"address"]
//			|| [elementName isEqualToString:@"birthday"]
//			|| [elementName isEqualToString:@"age"]
//			|| [elementName isEqualToString:@"blood"]
//			|| [elementName isEqualToString:@"sex"]
//			|| [elementName isEqualToString:@"tel"]
//			|| [elementName isEqualToString:@"mail"]
//			|| [elementName isEqualToString:@"job"]
//			|| [elementName isEqualToString:@"good_field"]
//			|| [elementName isEqualToString:@"full_name"]
//			|| [elementName isEqualToString:@"medical_history"]
//			|| [elementName isEqualToString:@"icon_path"]
//			|| [elementName isEqualToString:@"created_at"]
//			|| [elementName isEqualToString:@"updated_at"]) {
//			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
//			nodeName = [elementName copy];
//		}
//	}
//#else
    if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		personalsInfo = [[PersonalsInfo alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
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
			|| [elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
	
//#endif
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
//#if TARGET_IPHONE_SIMULATOR
//	if ([nodeName isEqualToString:@"users"] || [nodeName isEqualToString:@"user"]) {
//	} else {
//		[nodeContent appendString:string];
//	}
//#else
	if ([nodeName isEqualToString:ELEMENT_NAME_PERSONALS] || [nodeName isEqualToString:ELEMENT_NAME_PERSONAL]) {
	} else {
		[nodeContent appendString:string];
	}
//#endif
}
															  
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
//	NSLog(@"%@ = %@",elementName,nodeContent);
	// エレメント終了ハンドラ
	if (qualifiedName) {
		elementName = qualifiedName;
	}
//#if TARGET_IPHONE_SIMULATOR
//	if ([elementName isEqualToString:@"user"]) {
//		personalsInfo.weakKind = [[NSString alloc]initWithString:@"1"];
//		personalsInfo.age = [[NSString alloc]initWithString:@"30"];
//		[items addObject:personalsInfo];
//		[personalsInfo release];
//		personalsInfo = nil;
//	} else {
//		if ([elementName isEqualToString:@"users"]) {
//			mode = [[NSString alloc]initWithString:@"1"];			
//		}else {
//			
//			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
//			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
//				result = [[NSString alloc]initWithString:nodeContent];			
//			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
//				// エラーの場合
//				messages = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"id"]) {
//				personalsInfo.personalId = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"family_id"]) {
//				personalsInfo.familyId = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"family_name"]) {
//				personalsInfo.familyName = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"full_name"]) {
//				personalsInfo.fullName = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"address"]) {
//				personalsInfo.address = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"age"]) {
//				personalsInfo.age = @"20";
//			} else if ([elementName isEqualToString:@"blood"]) {
//				personalsInfo.blood = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"sex"]) {
//				personalsInfo.sex = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"tel"]) {
//				personalsInfo.personalTel = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"good_field"]) {
//				personalsInfo.goodField = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"medical_history"]) {
//				personalsInfo.medicalHistory = [[NSString alloc]initWithString:nodeContent];
//			} else if ([elementName isEqualToString:@"icon_path"]) {
//				personalsInfo.iconPath = [[NSString alloc]initWithString:nodeContent];
//			}
//			[nodeContent release];
//			nodeContent = nil;
//		}
//	}
//#else
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
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				messages = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
				personalsInfo.personalId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
				personalsInfo.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FULL_NAME]) {
				personalsInfo.fullName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_NAME]) {
				personalsInfo.familyName = [[NSString alloc]initWithString:nodeContent];
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
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				personalsInfo.updatedAt = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
//#endif
	[nodeName release];
	nodeName = nil;
}
			 
- (void)parserDidEndDocument:(NSXMLParser *)parser {
	// 解析終了時に実行する処理
	[self setDisasterInfoTab:[mode intValue]];
	if ([result isEqualToString:@"NG"] || messages != nil || [messages isEqualToString:@""]) {
		NSLog(@"検索結果がありませんでした。");
	}
	// indicator invisible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
