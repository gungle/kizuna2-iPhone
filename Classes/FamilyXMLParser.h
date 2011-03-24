//
//  FamilyXMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMLParser.h"
#define ELEMENT_NAME_FAMILIES      @"families"
#define ELEMENT_NAME_FAMILY        @"family"
#define ELEMENT_NAME_FAMILY_ID     @"family_id"
#define ELEMENT_NAME_CLASS_ID      @"class_id"
#define ELEMENT_NAME_CLASS_NAME    @"class_name"
#define ELEMENT_NAME_FAMILY_NAME   @"family_name"
#define ELEMENT_NAME_FAMILY_NUMBER @"family_number"
#define ELEMENT_NAME_WEAK_KIND     @"weak_kind"
#define ELEMENT_NAME_ADDRESS       @"address"
#define ELEMENT_NAME_HOME_TEL      @"home_tel"
#define ELEMENT_NAME_HOME_LAT      @"home_lat"
#define ELEMENT_NAME_HOME_LON      @"home_lon"
#define ELEMENT_NAME_UPDATED_AT    @"updated_at"

@class FamilyXMLParser;
@protocol FamilyXMLParserDelegate<NSObject>
@optional
- (void)familyXmlDidFinishInitialize:(FamilyXMLParser *)xmlParser;
@end

@class UFamilyMng;

@interface FamilyXMLParser : XMLParser {
	
	id<FamilyXMLParserDelegate> delegate;
	UFamilyMng *familyMng;		// 組情報管理
}

@property (nonatomic, assign) id<FamilyXMLParserDelegate> delegate;
@property (nonatomic, retain) UFamilyMng *familyMng;

+ (FamilyXMLParser *)sharedXMLParser;


@end
