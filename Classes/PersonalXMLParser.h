//
//  PersonalXMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMLParser.h"
#define ELEMENT_NAME_PERSONALS       @"personals"
#define ELEMENT_NAME_PERSONAL        @"personal"
#define ELEMENT_NAME_PERSONAL_ID     @"personal_id"
#define ELEMENT_NAME_FULL_NAME       @"full_name"
#define ELEMENT_NAME_ADDRESS         @"address"
#define ELEMENT_NAME_AGE             @"age"
#define ELEMENT_NAME_BLOOD           @"blood"
#define ELEMENT_NAME_SEX             @"sex"
#define ELEMENT_NAME_PERSONAL_TEL    @"personal_tel"
#define ELEMENT_NAME_WEAK_KIND       @"weak_kind"
#define ELEMENT_NAME_JOB             @"job"
#define ELEMENT_NAME_GOOD_FIELD      @"good_field"
#define ELEMENT_NAME_MEDICAL_HISTORY @"medical_history"
#define ELEMENT_NAME_ICON_PATH       @"icon_path"
#define ELEMENT_NAME_UPDATED_AT      @"updated_at"

@class PersonalXMLParser;
@protocol PersonalXMLParserDelegate<NSObject>
@optional
- (void)personalXmlDidFinishInitialize:(PersonalXMLParser *)xmlParser;
@end

@class UPersonalMng;


@interface PersonalXMLParser : XMLParser {
	
	id<PersonalXMLParserDelegate> delegate;
	UPersonalMng *personalMng;		// 組情報管理
}

@property (nonatomic, assign) id<PersonalXMLParserDelegate> delegate;
@property (nonatomic, retain) UPersonalMng *personalMng;

+ (PersonalXMLParser *)sharedXMLParser;


@end
