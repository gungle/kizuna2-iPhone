//
//  PersonalXMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalXMLParser.h"
#import "UPersonalMng.h"

static PersonalXMLParser *sharedPersonalXMLParser;


@implementation PersonalXMLParser

@synthesize delegate;
@synthesize personalMng;

+ (PersonalXMLParser *)sharedXMLParser {
	if (!sharedPersonalXMLParser) {
		NSLog(@"----- >>>>>>>>>>>>>> PersonalXMLParser");
		sharedPersonalXMLParser = [[PersonalXMLParser alloc] init];
	}
	return sharedPersonalXMLParser;
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
//	[parser setDelegate:sharedPersonalXMLParser];
	[parser setDelegate:self];
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
	NSLog(@"----->>>> dealloc");
	sharedPersonalXMLParser = nil;
    [super   dealloc];
	NSLog(@"----->>>> dealloc");
}

// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	NSLog(@"start element %@",elementName);
	if (qualifiedName) {
        elementName = qualifiedName;
    }
	
#if TARGET_IPHONE_SIMULATOR
    if ([elementName isEqualToString:@"user"]) {
		personalMng = [[UPersonalMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:@"id"]
			|| [elementName isEqualToString:@"family_id"]
			|| [elementName isEqualToString:@"full_name"]
			|| [elementName isEqualToString:@"full_name_kana"]
			|| [elementName isEqualToString:@"address"]
			|| [elementName isEqualToString:@"birthday"]
			|| [elementName isEqualToString:@"age"]
			|| [elementName isEqualToString:@"blood"]
			|| [elementName isEqualToString:@"sex"]
			|| [elementName isEqualToString:@"tel"]
			|| [elementName isEqualToString:@"mail"]
			|| [elementName isEqualToString:@"job"]
			|| [elementName isEqualToString:@"good_field"]
			|| [elementName isEqualToString:@"full_name"]
			|| [elementName isEqualToString:@"medical_history"]
			|| [elementName isEqualToString:@"icon_path"]
			|| [elementName isEqualToString:@"created_at"]
			|| [elementName isEqualToString:@"updated_at"]) {
			nodeContent = [[NSMutableString alloc] initWithCapacity:0];
			nodeName = [elementName copy];
		}
	}
#else
    if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		personalMng = [[personalMng alloc] init];
	} else {
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]
			|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
			|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
			|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
			|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
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
	
#endif
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{	
#if TARGET_IPHONE_SIMULATOR
	if ([nodeName isEqualToString:@"users"] || [nodeName isEqualToString:@"user"]) {
	} else {
		[nodeContent appendString:string];
	}
#else
	if ([nodeName isEqualToString:ELEMENT_NAME_PERSONALS] || [nodeName isEqualToString:ELEMENT_NAME_PERSONAL) {
	} else {
		[nodeContent appendString:string];
	}
#endif															 
}
															 
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
{
	NSLog(@"%@ = %@",elementName,nodeContent);
	// エレメント終了ハンドラ
	if (qualifiedName) {
		elementName = qualifiedName;
	}
#if TARGET_IPHONE_SIMULATOR
	if ([elementName isEqualToString:@"user"]) {
		personalMng.weakKind = [[NSString alloc]initWithString:@"1"];
		personalMng.age = [[NSString alloc]initWithString:@"30"];
		[items addObject:personalMng];
		[personalMng release];
		personalMng = nil;
	} else {
		if ([elementName isEqualToString:@"users"]) {
			mode = [[NSString alloc]initWithString:@"1"];			
		}else {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"id"]) {
				personalMng.personalId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"family_id"]) {
				personalMng.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"full_name"]) {
				personalMng.fullName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"address"]) {
				personalMng.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"age"]) {
				personalMng.age = @"20";
			} else if ([elementName isEqualToString:@"blood"]) {
				personalMng.blood = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"sex"]) {
				personalMng.sex = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"tel"]) {
				personalMng.personalTel = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"good_field"]) {
				personalMng.goodField = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"medical_history"]) {
				personalMng.medicalHistory = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:@"icon_path"]) {
				personalMng.iconPath = [[NSString alloc]initWithString:nodeContent];
			}
			[nodeContent release];
			nodeContent = nil;
		}
	}
#else
	if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL) {
		[items addObject:personalMng];
		[personalMng release];
		personalMng = nil;
	} else {
		if (![elementName isEqualToString:ELEMENT_NAME_PERSONALS]) {
			
			if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
				mode = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
				result = [[NSString alloc]initWithString:nodeContent];			
			} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
				// エラーの場合
				message = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
				personalMng.personalId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
				personalMng.familyId = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_FULL_NAME]) {
				personalMng.fullName = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ADDRESS]) {
				personalMng.address = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_AGE]) {
				personalMng.age = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_BLOOD]) {
				personalMng.blood = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_SEX]) {
				personalMng.sex = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_TEL]) {
				personalMng.personalTel = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_WEAK_KIND]) {
				personalMng.weakKind = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_JOB]) {
				personalMng.job = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_GOOD_FIELD]) {
				personalMng.goodField = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_MEDICAL_HISTORY]) {
				personalMng.medicalHistory = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_ICON_PATH]) {
				personalMng.iconPath = [[NSString alloc]initWithString:nodeContent];
			} else if ([elementName isEqualToString:ELEMENT_NAME_UPDATED_AT]) {
				personalMng.updatedAt = [[NSString alloc]initWithString:nodeContent];
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
	NSLog(@"personal parserDidEndDocument");
	[self.delegate personalXmlDidFinishInitialize:self];
}
		 
@end
