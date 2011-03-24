//
//  CommonViewController.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//
#import "Scope2AppDelegate.h"
#import "Scope2Properties.h"

@interface CommonViewController : UIViewController <NSXMLParserDelegate>{
	NSString *groupId;
	NSString *groupName;
	NSString *familyId;
	NSString *familyName;
	NSString *personalId;
	NSString *login;

	int displayId;

	// XML
	NSMutableArray  *items;
	NSString        *nodeName;
	NSMutableString *nodeContent;	
	NSString        *mode;
	NSString        *result;
	NSString        *messages;
	
	NSString        *results;
	
	BOOL           keyboardShown; // キーボード表示状態
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *familyId;
@property (nonatomic, retain) NSString *familyName;
@property (nonatomic, retain) NSString *personalId;
@property (nonatomic, retain) NSString *login;
@property (nonatomic) int displayId;

// XML
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain, readonly) NSString *mode;
@property (nonatomic, retain, readonly) NSString *result;
@property (nonatomic, retain, readonly) NSString *messages;
@property (nonatomic, retain, readonly) NSString *results;

@property (nonatomic) BOOL keyboardShown;


- (NSString *)getProperties:(NSString *)key;
- (NSString *)getProperties:(NSString *)key index:(NSInteger)index;
- (NSArray *)getPropertiesArray:(NSString *)key;
- (NSString *)getProperties:(NSString *)key propertyName:(NSString*)propertyName;
- (NSString *)getProperties:(NSString *)key indexName:(NSInteger)indexName;


- (NSString *)getApplicationProperties:(NSString *)key;
- (BOOL)setApplicationProperties:(NSString *)object key:(NSString *)key;
- (void)setGroupId;
- (void)setFamilyId;
- (void)setPersonalId;

- (void)confirmView:(NSString *)title message:(NSString *)message cancelBtnName:(NSString *)cancelBtnName okBtnName:(NSString *)okBtnName;
- (void)alertView:(NSString *)title message:(NSString *)message okBtnName:(NSString *)okBtnName;
- (void)alertApiErrorMessageView;

- (void)createMapButtonInNavicgation;
- (void)pushMapButton:(id)sender;

- (void)setDisasterInfoTab:(int)disasterMode;
- (int)getTabSelectedIndex;
- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error;
- (void)parseXMLFileAtData:(NSData *)data parseError:(NSError **)error;

- (void)registerForKeyboardNotifications;

@end
