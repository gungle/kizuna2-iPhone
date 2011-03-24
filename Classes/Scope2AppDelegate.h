//
//  Scope2AppDelegate.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Scope2AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, NSXMLParserDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
	UINavigationController *groupInfoNavi;
	UINavigationController *disasterInfoNavi;
	UINavigationController *settingsNavi;

	NSString *groupId;				// 組ID
	NSString *familyId;				// 世帯ID
	NSString *personalId;			// 個人ID

	// XML
	NSString        *nodeName;
	NSMutableString *nodeContent;	
	NSString        *mode;
	NSString        *result;
	NSString        *messages;

	SystemSoundID soundFileObject;
	int           alertMode;        // 0:Push Notification災害アラート 
									// 1:Push Notification災害情報共有アラート
									// 9:ログインエラーアラート
	int           modeKind;         // 0:平常時
									// 1:災害時

}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UINavigationController *groupInfoNavi;
@property (nonatomic, retain) UINavigationController *disasterInfoNavi;
@property (nonatomic, retain) UINavigationController *settingsNavi;

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *familyId;
@property (nonatomic, retain) NSString *personalId;


// XML
@property (nonatomic, retain, readonly) NSString *mode;
@property (nonatomic, retain, readonly) NSString *result;
@property (nonatomic, retain, readonly) NSString *messages;

//- (void)login;
- (void)login:(NSString*)loginId password:(NSString*)password;
- (void)sendProviderDeviceToken:(NSData *)token;
- (void)displayAfterAlert;
- (void)displayAfterDisasterInfoAlert;
- (void)displayAfterDisasterShareAlert;
- (void)displayAfterNormalModeAlert;

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error;
- (void)setDisasterInfoTab:(int)disasterMode;

@end

