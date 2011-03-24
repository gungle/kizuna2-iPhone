//
//  LoginXMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"

#define ELEMENT_NAME_LOGIN    @"login"
#define ELEMENT_NAME_PERSONAL @"personal"
#define ELEMENT_NAME_PERSONAL_ID @"personal_id"
#define ELEMENT_NAME_CLASS_ID  @"class_id"

@class LoginXMLParser;
@protocol LoginXMLParserDelegate<NSObject>
@optional
- (void)loginXmlDidFinishInitialize:(LoginXMLParser *)xmlParser;
@end

@interface LoginXMLParser : XMLParser {
	id<LoginXMLParserDelegate> delegate;
	NSString *classId;			// 組ID
	NSString *personalId;		// 個人ID
}

@property (nonatomic, assign) id<LoginXMLParserDelegate> delegate;
@property (nonatomic, retain) NSString *classId;
@property (nonatomic, retain) NSString *personalId;

+ (LoginXMLParser *)sharedXMLParser;

@end
