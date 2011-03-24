//
//  XMLParser.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ELEMENT_NAME_MODE     @"mode"
#define ELEMENT_NAME_RESULT   @"result"
#define ELEMENT_NAME_MESSAGE  @"message"

@interface XMLParser : NSObject <NSXMLParserDelegate>{
	NSMutableArray  *items;
	NSString        *nodeName;
	NSMutableString *nodeContent;
	
	NSString        *mode;
	NSString        *result;
	NSString        *message;
	// TODO
	bool			noteFlag;
}

@property (nonatomic, retain, readonly) NSMutableArray *items;

@property (nonatomic, retain, readonly) NSString *mode;
@property (nonatomic, retain, readonly) NSString *result;
@property (nonatomic, retain, readonly) NSString *message;


- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error;
- (void)authenticate;

@end
