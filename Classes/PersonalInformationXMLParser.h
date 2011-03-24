//
//  PersonalInformationXMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/08.
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

@class PersonalInformationXMLParser;
@protocol PersonalInformationXMLParserDelegate<NSObject>
@optional
- (void)personalXmlDidFinishInitialize:(PersonalInformationXMLParser *)xmlParser;
@end

@class UPersonalMng;


@interface PersonalInformationXMLParser : XMLParser {
	
	id<PersonalInformationXMLParserDelegate> delegate;
	UPersonalMng *personalMng;		// 組情報管理
}

@property (nonatomic, assign) id<PersonalInformationXMLParserDelegate> delegate;
@property (nonatomic, retain) UPersonalMng *personalMng;

+ (PersonalInformationXMLParser *)sharedXMLParser;


@end
