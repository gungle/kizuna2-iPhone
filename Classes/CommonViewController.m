//
//  CommonViewController.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "CommonViewController.h"
#import "PropertiesUtil.h"
#import "MapViewController.h"

@implementation CommonViewController

@synthesize groupId;
@synthesize groupName;
@synthesize familyId;
@synthesize familyName;
@synthesize personalId;
@synthesize login;
@synthesize displayId;

// XML
@synthesize items;
@synthesize mode;
@synthesize result;
@synthesize messages;
@synthesize results;

@synthesize keyboardShown;

- (id)init {
    if (self = [super init]) {
//		[self.view setHidden:YES];
		keyboardShown = FALSE;
	}
    return self;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

/*
 * プロパティ値取得
 */
- (NSString *)getProperties:(NSString *)key {
	return [PropertiesUtil getProperties:key];
}

/*
 * プロパティ値取得
 */
- (NSString *)getProperties:(NSString *)key index:(NSInteger)index {
	return [PropertiesUtil getProperties:key index:index];
}

/*
 * プロパティ値(配列)取得
 */
- (NSArray *)getPropertiesArray:(NSString *)key {
	return [PropertiesUtil getPropertiesArray:key];
}

/*
 * プロパティ値(辞書)取得
 */
- (NSDictionary *)getPropertiesDictionary:(NSString *)key {
	return [PropertiesUtil getPropertiesDictionary:key];
}

/*
 * プロパティ値(辞書から)取得
 */
- (NSString *)getProperties:(NSString *)key propertyName:(NSString*)propertyName {
	return [PropertiesUtil getProperties:key propertyName:propertyName];
}

/*
 * プロパティ値(配列から)取得
 */
- (NSString *)getProperties:(NSString *)key indexName:(NSInteger)indexName {
	return [PropertiesUtil getProperties:key indexName:indexName];
}


/*
 * アプリケーションプロパティ値取得
 */
- (NSString *)getApplicationProperties:(NSString *)key {
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	return [userDefaults stringForKey:key];
}

/*
 * アプリケーションプロパティ値保存
 */
- (BOOL)setApplicationProperties:(NSString *)object key:(NSString *)key {
//	NSLog(@"key %@",key);
//	NSLog(@"object %@",object);
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setObject:object forKey:key];
//	NSLog( @"synchronize..." );
//	if ( ![userDefaults synchronize] ) {
//		NSLog( @"failed ..." );
//		return FALSE;
//	}
	return TRUE;
}

/*
 * 組ID取得
 */
- (void)setGroupId {
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	groupId = [[NSString  alloc]initWithString:scope2Delegate.groupId];
}

/*
 * 家族ID取得
 */
- (void)setFamilyId {
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	familyId = [[NSString  alloc]initWithString:scope2Delegate.familyId];
}

/*
 * 個人ID取得
 */
- (void)setPersonalId {
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	personalId = [[NSString  alloc]initWithString:scope2Delegate.personalId];
}

/*
 * 災害モード設定
 */
- (void)setDisasterInfoTab:(int)disasterMode {
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	[scope2Delegate setDisasterInfoTab:disasterMode];
}

/*
 * 選択中のタブインデックスを返却する
 */
- (int)getTabSelectedIndex {
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	return [scope2Delegate.tabBarController selectedIndex];
}

// OK,CANCEL確認用AlertView表示
- (void)confirmView:(NSString *)title message:(NSString *)message cancelBtnName:(NSString *)cancelBtnName okBtnName:(NSString *)okBtnName {
	UIAlertView *alert = [[UIAlertView alloc]  
						  initWithTitle:title  
						  message:message
						  delegate:self
						  cancelButtonTitle:cancelBtnName		// cancel = 0
						  otherButtonTitles:okBtnName, nil];	// ok = 1
	[alert show];  
	[alert release];	
}

// OK確認用AlertView表示
- (void)alertView:(NSString *)title message:(NSString *)message okBtnName:(NSString *)okBtnName {
	UIAlertView *alert = [[UIAlertView alloc]  
						  initWithTitle:title  
						  message:message
						  delegate:self
						  cancelButtonTitle:nil					// cancel設定しない 
						  otherButtonTitles:okBtnName, nil];	// ok = 0
	[alert show];  
	[alert release];	
}

// 確認用AlertViewの返却判定
// 現在位置取得確認結果
// 個々のビューコントローラでオーバーライドしてください
- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	// confirmの場合
	// alertView.numberOfButtons > 1
	// buttonIndex = 0 → CANCEL
	// buttonIndex = 1 → OK
	
	// alertの場合
	// alertView.numberOfButtons = 1
	// buttonIndex = 0 → OK
}

- (void)alertApiErrorMessageView {
	[self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			message:[NSString stringWithFormat:@"%@取得に失敗しました",[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			okBtnName:@"OK"];
}

- (void)dealloc {
	[groupId    release];
	[groupName  release];
	[familyId   release];
	[familyName release];
	[personalId release];
	[login	    release];

	// XML
	[mode        release];
	[result      release];
	[messages    release];
	[results     release];
    [super     dealloc];
}


#pragma mark -
#pragma mark mapButton
- (void)createMapButtonInNavicgation {
	// Button
	UIBarButtonItem *mapButton = [[[UIBarButtonItem alloc] 
									initWithTitle:@"地図"
									style:UIBarButtonItemStylePlain
									target:self
									action:@selector(pushMapButton:)] autorelease];	
	self.navigationItem.rightBarButtonItem = mapButton;
}

- (void)pushMapButton:(id)sender {
	// 地図画面へ遷移
	MapViewController *mapViewController;
	
	if (displayId == DISPLAY_ID_02) {
		// 世帯一覧画面
		mapViewController= [[MapViewController alloc] initMapWithGroupId:groupId];
	} else if (displayId == DISPLAY_ID_03) {
		// 家族一覧画面
		mapViewController= [[MapViewController alloc] initMapWithFamilyId:familyId];
	} else if (displayId == DISPLAY_ID_04) {
		// 個人情報画面
		mapViewController= [[MapViewController alloc] initMapWithPersonalId:personalId];
	} else if (displayId == DISPLAY_ID_11) {
		// 災害一覧画面
		mapViewController= [[MapViewController alloc] initMapWithDisaster];
	} else {
		// 災害情報画面
		mapViewController= [[MapViewController alloc] initMapWithDisasterPersonalId:personalId];
	}

	[self.navigationController pushViewController:mapViewController animated:YES];
	 
	 [mapViewController release];
}

#pragma mark -
#pragma mark XML parse
- (void)parseXMLFileAtURL:(NSURL *)url parseError:(NSError **)error {
	NSLog(@"----- > %@ ",url);
	
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	
	
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];

	[parser parse];

	[parser release];
}

- (void)parseXMLFileAtData:(NSData *)data parseError:(NSError **)error {
	[[NSURLCache sharedURLCache] setMemoryCapacity:0];
	[[NSURLCache sharedURLCache] setDiskCapacity:0];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];

	[parser parse];
	NSError *parseError = [parser parserError];
	if (parseError && error) {
		*error = parseError;
		//		NSLog(@"error %@",parseError);
		UIAlertView *alert = [[UIAlertView alloc]  
							  initWithTitle:@"XML Parserエラー"  
							  message:@"XMLエラー"
							  delegate:self
							  cancelButtonTitle:nil					// cancel設定しない 
							  otherButtonTitles:@"OK", nil];		// ok = 0
		[alert show];  
		[alert release];	
	}
	[parser release];
	
}



#pragma mark -
#pragma mark registerForKeyboardNotifications
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasHidden:)
												 name:UIKeyboardDidHideNotification object:nil];
}
// UIKeyboardDidShowNotificationが送信されたときに呼び出される
- (void)keyboardWasShown:(NSNotification*)aNotification
{
}

// UIKeyboardDidHideNotificationが送信されたときに呼び出される
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
}

@end
