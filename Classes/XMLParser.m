//
//  XMLParser.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "XMLParser.h"
#import "PropertiesUtil.h"

@implementation XMLParser

@synthesize items;
@synthesize mode;
@synthesize result;
@synthesize message;

- (id)init {
	if (self = [super init]){
		items = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

- (void)dealloc {
	NSLog(@">>>> dealloc %d",[items count]);
	NSLog(@">>>> item");
	[nodeName    release];
	[nodeContent release];
	[mode        release];
	[result      release];
	[message     release];
	[super       dealloc];
//	if ([items count] > 0) {
//		NSLog(@">>>> release");
////		[items removeAllObjects];
//		NSLog(@">>>> release");
//		[items       release];
//	}
	NSLog(@">>>> dealloc");
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error
{
	NSLog(@"----- > %@ ",url);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	// 解析開始時に実行する処理
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	NSLog(@"parser didStartElement");
    // エレメント開始ハンドラ
    if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
		// 実行結果
	} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
		// メッセージ
	}
	nodeName = elementName;
	//	NSLog(@"----- > %@ start",elementName);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
{
	NSLog(@"parser didEndElement");
    // エレメント終了ハンドラ
    if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
		// 実行結果
	} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
		// メッセージ
	}
	//	NSLog(@"----- > %@ end",elementName);
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string  
{  
	NSLog(@"parser foundCharacters");
    // エレメントの文字データを string で取得  
    if ([nodeName isEqualToString:ELEMENT_NAME_RESULT]) {
		// 実行結果
	} else if ([nodeName isEqualToString:ELEMENT_NAME_MESSAGE]) {
		// メッセージ
	}
	//	NSLog(@"----- > %@ end",nodeName);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	NSLog(@"parser parserDidEndDocument");
	// 解析終了時に実行する処理
}


//- (void)authenticate:(NSString *)loginId password:(NSString *)password {
- (void)authenticate {
	static NSString* const BOUNDARY = @"scope2abcdefghijk";
	
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	
	// ログインID、パスワード取得
	NSString *loginId = [userDefaults stringForKey:@"login_id_preference"];
	NSString *password = [userDefaults stringForKey:@"password_preference"];
	//	NSLog(@"ログインID　= %@",loginId);
	//	NSLog(@"パスワード = %@",password);
	
	// グループID、ユーザID取得・設定
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@",
					 [PropertiesUtil getProperties:@"SERVER"], 
					 [PropertiesUtil getProperties:@"API_KEY_LOGIN"]
					 ];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];	
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];	
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	// login=ログインID
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"login\"\r\n\r\n%@", loginId] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[body appendData:[[NSString stringWithString:loginId] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	// password=パスワード
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"password\"\r\n\r\n%@", password] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[body appendData:[[NSString stringWithString:password] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	
	// URLコネクションを作る
	[NSURLConnection connectionWithRequest:request delegate:self];
	
}

@end
