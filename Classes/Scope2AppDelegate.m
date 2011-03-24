//
//  Scope2AppDelegate.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "Scope2AppDelegate.h"
#import "GroupListViewController.h"
#import "DisasterListViewController.h"
#import "SettingsViewController.h"
#import "PropertiesUtil.h"
#import "MapViewController.h"
#import "SafetyConfirmViewController.h"
#import "DisasterInfoSendViewController.h"

@implementation Scope2AppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize groupInfoNavi;
@synthesize disasterInfoNavi;
@synthesize settingsNavi;

@synthesize groupId;
@synthesize familyId;
@synthesize personalId;

@synthesize mode;
@synthesize result;
@synthesize messages;


#pragma mark -
#pragma mark Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	NSLog(@"didFinishLaunchingWithOptions launchOptions:%@",[launchOptions description]);

	// アラートモード 0:Push Notification 9:ログインエラー
	alertMode = 0;
	
	// 災害モード(初期は平常時:0)
	modeKind = 0;
	
	// ログイン
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	// ログインID、パスワード取得
	NSString *loginId  = [userDefaults stringForKey:@"login_id"];
	NSString *password  = [userDefaults stringForKey:@"password"];
		
	[self login:loginId password:password];
	
	// Override point for customization after application launch.
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// タブバーコントローラ作成
	tabBarController = [[UITabBarController alloc] init];
	tabBarController.delegate = self;
	// ナビゲーションコントローラ作成

	groupInfoNavi = [[UINavigationController alloc] initWithRootViewController:[[GroupListViewController alloc] init]];
	groupInfoNavi.title = [NSString stringWithString:[PropertiesUtil getProperties:@"TAB_NAME" index:0]];
	groupInfoNavi.tabBarItem.image =  [UIImage imageNamed:ICON_NAME_TAB_GROUP];
	
	disasterInfoNavi = [[UINavigationController alloc] initWithRootViewController:[[DisasterListViewController alloc] init]];
	disasterInfoNavi.title = [NSString stringWithString:[PropertiesUtil getProperties:@"TAB_NAME" index:1]];
	disasterInfoNavi.tabBarItem.image =  [UIImage imageNamed:ICON_NAME_TAB_DISASTER];

	settingsNavi = [[UINavigationController alloc] initWithRootViewController:[[SettingsViewController alloc] init]];
	settingsNavi.title = [NSString stringWithString:[PropertiesUtil getProperties:@"TAB_NAME" index:2]];
	settingsNavi.tabBarItem.image =  [UIImage imageNamed:ICON_NAME_TAB_SETTINGS];
	
	// タブ設定
	//	[tabBarController setViewControllers:[NSArray arrayWithObjects:groupInfoNavi, settingsNavi, nil] animated:NO];
	[self setDisasterInfoTab:[mode intValue]];
	[window addSubview:tabBarController.view];

	// 自動ロック無効
	//	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
	
	[window makeKeyAndVisible];

	
	if (launchOptions != NULL) {
		NSDictionary *userInfo = [launchOptions objectForKey:[NSString stringWithString:@"UIApplicationLaunchOptionsRemoteNotificationKey"]];
		NSDictionary *pushNorificationInfo = [userInfo objectForKey:[NSString stringWithString:@"aps"]];
//		NSLog(@">mode %@",[pushNorificationInfo objectForKey:[NSString stringWithString:@"shareMode"]]);
		alertMode = [[pushNorificationInfo objectForKey:[NSString stringWithString:@"alertMode"]] intValue];
		modeKind = [[pushNorificationInfo objectForKey:[NSString stringWithString:@"modeKind"]] intValue];
		[self displayAfterAlert];
	}
	
	NSString* srcPath;
	NSURL*  url;
	// オーディオファイルパス
	srcPath = PUSH_NOTIFICATION_SOUND;
	// オーディオファイルのURLを取得する
	url = [NSURL fileURLWithPath:srcPath];
	// システムサウンドを作成する
	AudioServicesCreateSystemSoundID((CFURLRef)url, &soundFileObject);
	
	
	return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//	NSLog(@"login_id = %@",[userDefaults objectForKey:@"login_id"]);
//	NSLog(@"password = %@",[userDefaults objectForKey:@"password"]);
//	NSLog( @"synchronize..." );
	if ( ![userDefaults synchronize] ) {
		NSLog( @"userDefaults synchronize...failed" );
	}
	
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

/*
 * アラート後の画面遷移
 * Push Notification受信後の処理
 */
- (void)displayAfterAlert {
	if (alertMode == 0) {
		// 災害情報アラート 地図画面へ遷移
		[self displayAfterDisasterInfoAlert];
	} else {
		if (modeKind == 0) {
			// 災害モード変更アラート 0  平常時画面へ 
			[self displayAfterNormalModeAlert];
		} else {
			// 被害者情報アラート 災害情報一覧へ遷移
			// 災害モード変更アラート 災害情報一覧へ遷移 
			[self displayAfterDisasterShareAlert];
		}

	}
}

/*
 * 安否確認画面へ遷移する
 * Push Notification受信後の処理
 */
- (void)displayAfterDisasterInfoAlert {
	// push → 災害モード
	// 安否確認画面に遷移する
	// 2010/10/19 仕様変更
	// 災害時の地図画面に遷移する
	
	// 2010/12/15 バグ対応
	// 災害モード時の場合アプリが落ちるのを改善
//	DisasterListViewController *viewController = (DisasterListViewController*)[disasterInfoNavi topViewController];
////	[viewController pushSafetyInputButton:self];
//	[viewController pushMapButton:self];
//	[tabBarController setSelectedIndex:1];

	DisasterListViewController *viewController;
	
	[tabBarController setSelectedIndex:1];
	[disasterInfoNavi popToRootViewControllerAnimated:NO];
	viewController = (DisasterListViewController*)[disasterInfoNavi topViewController];
	[viewController pushMapButton:self];


}

/*
 * 災害一覧画面へ遷移する
 * Push Notification受信後の処理
 */
- (void)displayAfterDisasterShareAlert {
	// 災害一覧画面に遷移する
	// 2010/11/01 仕様追加
	[disasterInfoNavi popViewControllerAnimated:YES];
	DisasterListViewController *viewController = (DisasterListViewController*)[disasterInfoNavi topViewController];
	[viewController viewWillAppear:YES];
	[tabBarController setSelectedIndex:1];
}

/*
 * 平常時画面へ遷移する
 * Push Notification受信後の処理
 */
- (void)displayAfterNormalModeAlert {
	// push → 災害モード変更
	// 平常時画面に遷移する
	// 2010/11/16 仕様追加
	[disasterInfoNavi popViewControllerAnimated:YES];
	[tabBarController setSelectedIndex:0];
}

#pragma mark -
#pragma mark apns delegate
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSLog(@">Push Notification");
	NSLog(@">userInfo %@",userInfo);
	NSDictionary *pushNorificationInfo = [userInfo objectForKey:[NSString stringWithString:@"aps"]];

	NSLog(@">alertMode %@",[pushNorificationInfo objectForKey:[NSString stringWithString:@"alertMode"]]);
	NSLog(@">modeKind %@",[pushNorificationInfo objectForKey:[NSString stringWithString:@"modeKind"]]);
	
	
	// サウンドを鳴らす
	AudioServicesPlayAlertSound(soundFileObject);
	
	// Push Notificationのアラート
	alertMode = [[pushNorificationInfo objectForKey:[NSString stringWithString:@"alertMode"]] intValue];
	// 災害モード
	modeKind = [[pushNorificationInfo objectForKey:[NSString stringWithString:@"modeKind"]] intValue];

	UIAlertView *alert = [[UIAlertView alloc] 
						  // 修正事項 2010/11/30 アプリ名表示
//						  initWithTitle:@"SCOPE2"
						  initWithTitle:[[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]
						  message:[pushNorificationInfo objectForKey:[NSString stringWithString:@"alert"]]
						  delegate:self
						  // OKボタンだけにする 2010/11/16
//						  cancelButtonTitle:@"閉じる"		// cancel = 0
//						  otherButtonTitles:@"表示する", nil];	// ok = 1
						  cancelButtonTitle:nil
						  otherButtonTitles:@"OK", nil];	// ok = 1
	
    [alert show];
    [alert release];

}

- (void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)devToken { 
	NSLog(@"deviceToken: %@", devToken); 
	//	self.devToken;
	[self sendProviderDeviceToken:devToken];
}

- (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)err{ 
	NSLog(@"Errorinregistration.Error:%@",err);
	
}

/*
 * アラート選択処理
 * アラート（確認）ビューのボタン処理
 */
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

	if (alertMode == 9) {
		return;
	}
	// タブ追加・削除
	[self setDisasterInfoTab:modeKind];
	
	// 2010/11/16
	// OKぼたんのみに変更
//	if (buttonIndex == 1) {
	if (buttonIndex == 0) {
		[self displayAfterAlert];
	}
}

#pragma mark -
#pragma mark local method
- (void)sendProviderDeviceToken:(NSData *)token {
	
	NSString *deviceToken = [[[[token description]
							stringByReplacingOccurrencesOfString:@"<"withString:@""]
							stringByReplacingOccurrencesOfString:@">" withString:@""]
							stringByReplacingOccurrencesOfString: @" " withString: @""];	
	NSMutableData *body = [NSMutableData data];

	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_DEVICETOKEN] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_PERSONAL_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:personalId] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_PERSONAL_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_DEVICE_TOKEN] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:deviceToken] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_DEVICE_TOKEN] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_DEVICETOKEN] dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	
	NSString *url = [NSString stringWithFormat:@"%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [PropertiesUtil getProperties:@"SERVER_DEBUG"], 
#else	
					 [PropertiesUtil getProperties:@"SERVER"], 
#endif
					 [PropertiesUtil getProperties:@"API_KEY_DEVICE_TOKENS"]];
	
	NSLog(@"url  = %@", url);
	
	request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//	[request setValue:@"application/x-www-form-unlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:body];
	
//	NSLog(@"body  = %@", body);
	
	[NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection*)connection
	didReceiveData:(NSData*)data {
	char* p = (char*)[data bytes];
	int len = [data length];
	while (len-- > 0) {
		putchar(*p++);
	}
	
}

- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error {

	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser parse];
	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
		NSLog(@"error %@",parseError);
		alertMode = 9;
		UIAlertView *alert = [[UIAlertView alloc]  
							  initWithTitle:@"ログインエラー"  
							  message:@"サーバエラー"
							  delegate:self
							  cancelButtonTitle:nil					// cancel設定しない 
							  otherButtonTitles:@"OK", nil];		// ok = 0
		[alert show];  
		[alert release];
	}
	[parser release];
}

- (void)login:(NSString*)loginId password:(NSString*)password {
    // ログイン認証
	NSError *parseError = nil;
	
	// indicator visible
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
	if (loginId == NULL || loginId == nil || [loginId isEqualToString:@""]
		|| password == NULL || password == nil || [password isEqualToString:@""]) {
		alertMode = 9;
		UIAlertView *alert = [[UIAlertView alloc]  
							  initWithTitle:@"ログイン情報設定"  
							  message:@"設定画面よりログイン情報を設定してください"
							  delegate:self
							  cancelButtonTitle:nil					// cancel設定しない 
							  otherButtonTitles:@"OK", nil];		// ok = 0
		[alert show];
		[alert release];
	} else {
		NSLog(@"login = %@",loginId);
		NSLog(@"password = %@",password);
		
		// ログイン（認証）リクエストURL
		NSString *url = [[NSString alloc]initWithFormat:@"%@%@?login=%@&password=%@",
#if TARGET_IPHONE_SIMULATOR
						 [PropertiesUtil getProperties:@"SERVER_DEBUG"], 
#else
						 [PropertiesUtil getProperties:@"SERVER"], 
#endif
						 [PropertiesUtil getProperties:@"API_KEY_LOGINS"],
						 loginId,
						 password];
		
		[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
		[url release];
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark Memory management
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	AudioServicesDisposeSystemSoundID(soundFileObject);	
	[groupId          release];
	[familyId         release];
	[personalId       release];
	[mode             release];
	[result           release];
	[messages         release];
	[settingsNavi     release];
	[disasterInfoNavi release];
	[groupInfoNavi    release];
    [tabBarController release];
    [window           release];
    [super            dealloc];
}

#pragma mark -
#pragma mark change mode
/*
 * 災害時モード変更によるタブの表示設定
 */
- (void)setDisasterInfoTab:(int)disasterMode{
	if (disasterMode == 1) {
		// 災害時モードの場合
		[tabBarController setViewControllers:[NSArray arrayWithObjects:groupInfoNavi, disasterInfoNavi, settingsNavi, nil] animated:NO];
	} else {
		// 平常時モードの場合
		[tabBarController setViewControllers:[NSArray arrayWithObjects:groupInfoNavi, settingsNavi, nil] animated:NO];
	}
//	[tabBarController setViewControllers:[NSArray arrayWithObjects:groupInfoNavi, disasterInfoNavi, settingsNavi, nil] animated:NO];
}

#pragma mark -
#pragma mark UITabBarControllerDelegate
// タブが選択され画面が切り替わる前に呼び出されるメソッド
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
	// 災害モード時の制御
	return YES; // YES…遷移可　NO…遷移不可
}

// タブが選択され画面が切り替った後に呼び出されるメソッド
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//	[self setDisasterInfoTab:0];
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
}


- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}


#pragma mark -
#pragma mark NSXMLParserDelegate
// エレメント開始ハンドラ
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
    if ([elementName isEqualToString:ELEMENT_NAME_MODE]
		|| [elementName isEqualToString:ELEMENT_NAME_RESULT]
		|| [elementName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]
		|| [elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]
		|| [elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
		nodeContent = [[NSMutableString alloc] initWithCapacity:0];
	}
	nodeName = [elementName copy];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {  
    if ([nodeName isEqualToString:ELEMENT_NAME_MODE]
		|| [nodeName isEqualToString:ELEMENT_NAME_RESULT]
		|| [nodeName isEqualToString:ELEMENT_NAME_MESSAGE]
		|| [nodeName isEqualToString:ELEMENT_NAME_GROUP_ID]
		|| [nodeName isEqualToString:ELEMENT_NAME_FAMILY_ID]
		|| [nodeName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
		// エレメントの文字データを string で取得
		[nodeContent appendString:string];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName {
    // エレメント終了ハンドラ
    if (qualifiedName) {
        elementName = qualifiedName;
    }
	
	if (![elementName isEqualToString:ELEMENT_NAME_LOGIN]
		&& ![elementName isEqualToString:ELEMENT_NAME_PERSONAL]) {
		
		if ([elementName isEqualToString:ELEMENT_NAME_MODE]) {
			mode = [[NSString alloc]initWithString:nodeContent];			
		} else if ([elementName isEqualToString:ELEMENT_NAME_RESULT]) {
			result = [[NSString alloc]initWithString:nodeContent];			
		} else if ([elementName isEqualToString:ELEMENT_NAME_MESSAGE]) {
			// エラーの場合
			messages = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_GROUP_ID]) {
			groupId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_FAMILY_ID]) {
			familyId = [[NSString alloc]initWithString:nodeContent];
		} else if ([elementName isEqualToString:ELEMENT_NAME_PERSONAL_ID]) {
			personalId = [[NSString alloc]initWithString:nodeContent];
		}
		[nodeContent release];
		nodeContent = nil;
	}
	[nodeName release];
	nodeName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	// 解析終了時に実行する処理
	if ([result isEqualToString:@"NG"]) {
		NSLog(@"検索結果がありませんでした %@",messages);
		alertMode = 9;
		UIAlertView *alert = [[UIAlertView alloc]  
							  initWithTitle:@"ログインエラー"  
							  message:@"ログインに失敗しました"
							  delegate:self
							  cancelButtonTitle:nil					// cancel設定しない 
							  otherButtonTitles:@"OK", nil];		// ok = 0
		[alert show];  
		[alert release];
	} else {
		// PUSH NOTIFY
		[[UIApplication sharedApplication] 
		 registerForRemoteNotificationTypes:
		 (
		  //UIRemoteNotificationTypeBadge| 
		  UIRemoteNotificationTypeSound|
		  UIRemoteNotificationTypeAlert)];
		
	}

	// indicator invisible
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}

@end
