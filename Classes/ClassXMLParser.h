//
//  ClassXMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/07.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XMLParser.h"
#define ELEMENT_NAME_CLASSES       @"classes"
#define ELEMENT_NAME_CLASS         @"class"
#define ELEMENT_NAME_CLASS_ID      @"class_id"
#define ELEMENT_NAME_CLASS_NAME    @"class_name"
#define ELEMENT_NAME_FAMILY_NUMBER @"family_number"
#define ELEMENT_NAME_UPDATED_AT    @"updated_at"

@class ClassXMLParser;
@protocol ClassXMLParserDelegate<NSObject>
@optional
- (void)classXmlDidFinishInitialize:(ClassXMLParser *)xmlParser;
@end

@class UClassMng;

@interface ClassXMLParser : XMLParser {
	id<ClassXMLParserDelegate> delegate;
	UClassMng *classMng;		// 組情報管理
}

@property (nonatomic, assign) id<ClassXMLParserDelegate> delegate;
@property (nonatomic, retain) UClassMng *classMng;

+ (ClassXMLParser *)sharedXMLParser;

@end
