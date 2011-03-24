//
//  DisasterInfoSendViewController.m
//  Scope2
//	(13)災害情報送信画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/15.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterInfoSendViewController.h"
#import "DisasterPickerView.h"
#import "PersonalsInfo.h"
#import "CommonScrollView.h"


@implementation DisasterInfoSendViewController

@synthesize pickerView;
@synthesize photoViewOff;
@synthesize photoViewOn;
@synthesize locationViewOff;
@synthesize locationViewOn;
@synthesize clipImage;
@synthesize markerImage;
@synthesize orgImage;
@synthesize disasterMemo;
@synthesize locationManager;
@synthesize disasterInfoView;


- (id)initDisasterInfoSendView:(DisastersInfo *)selectedDisasterMng {
	if (self = [super init]) {
		self.displayId = DISPLAY_ID_13;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:self.displayId];
		[self setFamilyId];
		
		// 個人情報一覧取得
		self.items = [[NSMutableArray alloc] initWithCapacity:0];
		
		// 個人情報XML取得
		[self requestDisasterInfoSend];
		
		locationFlag = NO;
		photoFlag    = NO;
		
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
//	UIView *disasterInfoView = [[UIView alloc]initWithFrame:[self.view bounds]];
	disasterInfoView = [[CommonScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
	disasterInfoView.pagingEnabled = NO;
	disasterInfoView.contentSize = CGSizeMake(320, 500);
	disasterInfoView.showsHorizontalScrollIndicator = NO;
	disasterInfoView.showsVerticalScrollIndicator = NO;
	disasterInfoView.scrollsToTop = YES;
	self.view = disasterInfoView;
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	disasterInfoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	disasterInfoView.scrollEnabled = FALSE;
	
	// 画像
	locationViewOff = [[UIButton alloc]initWithFrame:CGRectMake(DISASTER_SEND_LOCATION_OFF_ICON_X,
																DISASTER_SEND_LOCATION_OFF_ICON_Y,
																DISASTER_SEND_LOCATION_OFF_ICON_WIDTH,
																DISASTER_SEND_LOCATION_OFF_ICON_HEIGHT)];
	[locationViewOff setBackgroundImage:[UIImage imageNamed:ICON_NAME_LOCATION_0] forState:UIControlStateNormal];
//	[locationViewOff setTitle:@"位置情報設定" forState:UIControlStateNormal];
	[locationViewOff addTarget:self action:@selector(pushLocationOff:) forControlEvents:UIControlEventTouchUpInside];	
	[disasterInfoView addSubview:locationViewOff];

	
	locationViewOn = [[UIButton alloc]initWithFrame:CGRectMake(DISASTER_SEND_LOCATION_ON_ICON_X,
															   DISASTER_SEND_LOCATION_ON_ICON_Y,
															   DISASTER_SEND_LOCATION_ON_ICON_WIDTH,
															   DISASTER_SEND_LOCATION_ON_ICON_HEIGHT)];
	[locationViewOn setBackgroundImage:[UIImage imageNamed:ICON_NAME_LOCATION_1] forState:UIControlStateNormal];
//	[locationViewOn setTitle:@"位置情報解除" forState:UIControlStateNormal];
	[locationViewOn addTarget:self action:@selector(pushLocationOn:) forControlEvents:UIControlEventTouchUpInside];	
	locationViewOn.hidden = YES;
	[disasterInfoView addSubview:locationViewOn];

	
	photoViewOff = [[UIButton alloc]initWithFrame:CGRectMake(DISASTER_SEND_PHOTO_OFF_ICON_X,
															 DISASTER_SEND_PHOTO_OFF_ICON_Y,
															 DISASTER_SEND_PHOTO_OFF_ICON_WIDTH,
															 DISASTER_SEND_PHOTO_OFF_ICON_HEIGHT)];
	[photoViewOff setBackgroundImage:[UIImage imageNamed:ICON_NAME_CAMERA_0] forState:UIControlStateNormal];
//	[photoViewOff setTitle:@"写真添付" forState:UIControlStateNormal];
	[photoViewOff addTarget:self action:@selector(pushPhotoOff:) forControlEvents:UIControlEventTouchUpInside];	
	[disasterInfoView addSubview:photoViewOff];
	
	
	photoViewOn = [[UIButton alloc]initWithFrame:CGRectMake(DISASTER_SEND_PHOTO_ON_ICON_X,
															DISASTER_SEND_PHOTO_ON_ICON_Y,
															DISASTER_SEND_PHOTO_ON_ICON_WIDTH,
															DISASTER_SEND_PHOTO_ON_ICON_HEIGHT)];
	[photoViewOn setBackgroundImage:[UIImage imageNamed:ICON_NAME_CAMERA_1] forState:UIControlStateNormal];
//	[photoViewOn setTitle:@"添付削除" forState:UIControlStateNormal];
	[photoViewOn addTarget:self action:@selector(pushPhotoOn:) forControlEvents:UIControlEventTouchUpInside];	
	photoViewOn.hidden = YES;
	[disasterInfoView addSubview:photoViewOn];
	
	markerImage = [[UIImageView alloc] init];
	[markerImage setImage:[UIImage imageNamed:ICON_NAME_MARKER]];
	markerImage.frame = CGRectMake(DISASTER_SEND_MARKER_ICON_X, DISASTER_SEND_MARKER_ICON_Y, DISASTER_SEND_MARKER_ICON_WIDTH, DISASTER_SEND_MARKER_ICON_HEIGHT);
	[markerImage setHidden:YES];
	[disasterInfoView addSubview:markerImage];
	
	clipImage = [[UIImageView alloc] init];
	[clipImage setImage:[UIImage imageNamed:ICON_NAME_CLIP]];
	clipImage.frame = CGRectMake(DISASTER_SEND_CLIP_ICON_X, DISASTER_SEND_CLIP_ICON_Y, DISASTER_SEND_CLIP_ICON_WIDTH, DISASTER_SEND_CLIP_ICON_HEIGHT);
	[clipImage setHidden:YES];
	[disasterInfoView addSubview:clipImage];
	
	// 2010/10/19 仕様変更
	// 災害メモ
	disasterMemo = [[UITextField alloc] initWithFrame:CGRectMake(DISASTER_SEND_DISASTER_MEMO_X, 
																 DISASTER_SEND_DISASTER_MEMO_Y, 
																 DISASTER_SEND_DISASTER_MEMO_WIDTH, 
																 DISASTER_SEND_DISASTER_MEMO_HEIGHT)]; 
	disasterMemo.font = [UIFont systemFontOfSize:DISASTER_SEND_FONT_SIZE];
	disasterMemo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	disasterMemo.backgroundColor = [UIColor whiteColor];
	disasterMemo.clearButtonMode = UITextFieldViewModeWhileEditing;
	disasterMemo.delegate = self;
	disasterMemo.keyboardType = UIKeyboardTypeDefault;
	PersonalsInfo *info = (PersonalsInfo*)[self.items objectAtIndex:0];
	if (info != nil) {
		disasterMemo.text = info.disasterMemo;
	}
	[disasterInfoView addSubview:disasterMemo];
	
	
	// 送信ボタン
	UIBarButtonItem *sendButton = [[[UIBarButtonItem alloc] 
								   initWithTitle:@"送信"
								   style:UIBarButtonItemStylePlain
								   target:self
								   action:@selector(pushSendButton:)] autorelease];	
	self.navigationItem.rightBarButtonItem = sendButton;
	
	// 緊急度、状況PickerView
	pickerView = [[DisasterPickerView alloc]initWithFramePersonals:CGRectMake(DISASTER_SEND_EMERGENCY_LIST_PICKER_X,
																	 DISASTER_SEND_EMERGENCY_LIST_PICKER_Y,
																	 DISASTER_SEND_EMERGENCY_LIST_PICKER_WIDTH,
																	 DISASTER_SEND_EMERGENCY_LIST_PICKER_HEIGHT)
																	items:(NSMutableArray*)self.items];
//	pickerView.hidden = YES;
	pickerView.pickerViewDelegate = self;
	[disasterInfoView addSubview:pickerView];
	
	

	self.view = disasterInfoView;
	
	// キーボード呼び出し
	[self registerForKeyboardNotifications];
	
}	
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[pickerView      release];
	[photoViewOff    release];
	[photoViewOn     release];
	[locationViewOff release];
	[locationViewOn  release];
	[clipImage       release];
	[markerImage     release];
	[orgImage        release];
	[disasterMemo    release];
	[locationManager release];
	[disasterInfoView setDelegate:nil];
	[disasterInfoView release];
    [super           dealloc];
}

- (void)requestDisasterInfoSend {
	// Table
	NSError *parseError = nil;  
	
	//------------------------------
	// 5.1 個人情報一覧・詳細取得リクエスト 
	//------------------------------
	
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?family_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_PERSONALS"],
					 self.familyId];
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
}

#pragma mark -
#pragma mark Button actions
- (void)pushSendButton:(id)sender {
	// 送信処理
	[self postData];
}

- (void)pushLocationOff:(id)sender {
	actionMode = 1;

	[self getGpsLocation];
	
}

- (void)pushLocationOn:(id)sender {
	// 位置情報削除
	locationFlag = NO;
	[locationViewOff setHidden:NO];
	[locationViewOn setHidden:YES];
	[markerImage setHidden:YES];
}

- (void)pushPhotoOff:(id)sender {
	actionMode = 0;

	// イメージピッカー起動
    // アクションシート
    UIActionSheet*  sheet;
    sheet = [[UIActionSheet alloc] 
			 initWithTitle:@"Select Soruce Type" 
			 delegate:self 
			 cancelButtonTitle:@"Cancel" 
			 destructiveButtonTitle:nil 
			 otherButtonTitles:@"Photo Library", @"Camera", nil];
    [sheet autorelease];
	
    // アクションシートを表示する
    [sheet showInView:self.view];
}

- (void)pushPhotoOn:(id)sender {
	// 写真添付削除
	photoFlag = NO;
	
	// 写真データ削除
	[orgImage release];
	orgImage = nil;
	[photoViewOff setHidden:NO];
	[photoViewOn setHidden:YES];
	[clipImage setHidden:YES];
}


// 現在位置取得確認
- (void)confirmGetLocation {
	// 現在位置取得確認
	[self confirmView:@"現在位置取得" 
			  message:@"現在の位置情報を利用します。\nよろしいですか？" 
		cancelBtnName:@"許可しない"
			okBtnName:@"OK"];
}


// GPS現在位置取得
- (void)getGpsLocation{
	// 現在位置取得
	// CLLocationManagerのインスタンスを作成
	locationManager = [[CLLocationManager alloc] init];
	
	// SDK 3.2
	//	if ([locationManager locationServicesEnabled]) {
	// SDK 4.0
	if ([CLLocationManager locationServicesEnabled]) {
		// ロケーションサービスが利用できる場合
		NSLog(@"----- > ロケーションサービス利用");
		locationManager.delegate = self;
		locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 位置測定の望みの精度を設定
		locationManager.distanceFilter = kCLDistanceFilterNone; // 位置情報更新の目安距離
		// 現在地情報受信開始
		[locationManager startUpdatingLocation];		
	} else {
		// ロケーションサービスが利用できない場合
		NSLog(@"----- > ロケーションサービス利用不可");
	}
}

- (void)postData {
	static NSString* const BOUNDARY = @"------ScopeProject2010";
	
	//------------------------------
	// 7.3 災害情報登録リクエスト 
	//------------------------------
	NSString *url = [NSString stringWithFormat:@"%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"],
#else
					 [self getProperties:@"SERVER"],
#endif
					 [self getProperties:@"API_KEY_DISASTERS"]];
	NSLog(@"---- > %@",url);

	// personal_id
	PersonalsInfo *info = [self.items objectAtIndex:[pickerView personalValue]];
	NSLog(@"---- > 選択されたpersonalId = %@",info.personalId);
	
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	
	NSString *contentType;
	
	NSMutableData *body = [NSMutableData data];
	contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];
	[request addValue:contentType forHTTPHeaderField:@"Content-Type"];
		
	[body appendData:[[NSString stringWithFormat:@"--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[personal_id]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",info.personalId] dataUsingEncoding:NSUTF8StringEncoding]];
	
	// emergency_kind
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[emergency_kind]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%d",[pickerView emergencyKindValue]] dataUsingEncoding:NSUTF8StringEncoding]];
		
	// disaster_status_kind
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[disaster_status_kind]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%d",[pickerView disasterStatusKindValue]] dataUsingEncoding:NSUTF8StringEncoding]];

	// disaster_memo
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[disaster_memo]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	//	[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%@",info.disasterMemo] dataUsingEncoding:NSUTF8StringEncoding]];
	
	if (locationFlag) {
		// now_lat
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[now_lat]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//		[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"%f",presentLocation.latitude] dataUsingEncoding:NSUTF8StringEncoding]];
		
		// now_lon
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[now_lon]\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//		[body appendData:[[NSString stringWithString:@"Content-Type: text/plain;charset=utf8\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"%f",presentLocation.longitude] dataUsingEncoding:NSUTF8StringEncoding]];
	}

	if (photoFlag) {
		// picture
		[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"disaster[picture]\"; filename=\"test.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
		NSData* imageData = UIImageJPEGRepresentation(orgImage, 1.0);
		[body appendData:imageData];
	}
	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",BOUNDARY] dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPBody:body];
	
//	NSLog(@"%@", [request allHTTPHeaderFields]);		
	
	// URLコネクションを作る
	[NSURLConnection connectionWithRequest:request delegate:self];
	
}

#pragma mark -
#pragma mark 
- (void)connection:(NSURLConnection*)connection
	didReceiveData:(NSData*)data
{
	char* p = (char*)[data bytes];
	int len = [data length];
	while (len-- > 0) {
		putchar(*p++);
	}
	
	// XML解析
	NSError *parseError = nil;
	[self parseXMLFileAtData:data parseError:&parseError];
	
	// error判定
	if ([self.results isEqualToString:@"NG"]) {
		[self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:self.displayId]]
				message:[NSString stringWithFormat:@"%@に失敗しました",[self getProperties:@"DISPLAY_TITLE" indexName:self.displayId]]
			  okBtnName:@"OK"];
	} else {
		[self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:self.displayId]]
				message:[NSString stringWithFormat:@"%@に成功しました",[self getProperties:@"DISPLAY_TITLE" indexName:self.displayId]]
			  okBtnName:@"OK"];
	}
}

#pragma mark -
#pragma mark CLLocationManagerDelegate
// 現在位置取得成功時の処理
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	// 位置情報を取り出す
	presentLocation.latitude  = newLocation.coordinate.latitude;
	presentLocation.longitude  = newLocation.coordinate.longitude;
	
	[locationViewOff setHidden:YES];
	[locationViewOn setHidden:NO];
	[markerImage setHidden:NO];
	
	// 位置情報取得・追加
	locationFlag = YES;
}

// 現在位置取得失敗時の処理
- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error {
//	[locationManager stopUpdatingLocation];
	[self alertView:@"現在取得エラー" message:@"位置情報が取得できませんでした" okBtnName:@"OK"];
}

#pragma mark -
#pragma mark DisasterPickerViewDelegate
- (void)selectedDidFinishInitialize:(DisasterPickerView *)pcView {
	PersonalsInfo *info = [self.items objectAtIndex:[pcView personalValue]];
	NSLog(@"selectedDidFinishInitialize > = %d",[pcView personalValue]);
	disasterMemo.text = info.disasterMemo;
	NSLog(@" > = %@",disasterMemo.text);
}


#pragma mark -
#pragma mark UIKeyboardDidShowNotification
// UIKeyboardDidShowNotificationが送信されたときに呼び出される
- (void)keyboardWasShown:(NSNotification*)aNotification
{
	NSLog(@"keyboardWasShown >");
    if (self.keyboardShown)
        return;
	disasterInfoView.scrollEnabled = TRUE;
	
    NSDictionary* info = [aNotification userInfo];
    // キーボードのサイズを取得する
	//	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
    // Scroll View（このウインドウのルートビュー）をサイズ変更する
    CGRect viewFrame = [disasterInfoView frame];
	UINavigationBar *naviBar = self.navigationController.navigationBar;
	// navigationbarを考慮
    viewFrame.size.height -= keyboardSize.height - (naviBar.bounds.size.height);
    disasterInfoView.frame = viewFrame;
	
    // アクティブなText Fieldが表示されるようにスクロールする
    CGRect textFieldRect = [disasterMemo frame];
    [disasterInfoView scrollRectToVisible:textFieldRect animated:YES];
    self.keyboardShown = TRUE;
	
	disasterInfoView.scrollEnabled = FALSE;
	
}

// UIKeyboardDidHideNotificationが送信されたときに呼び出される
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
	disasterInfoView.scrollEnabled = TRUE;
	
    NSDictionary* info = [aNotification userInfo];
    // キーボードのサイズを取得する
	//    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
    // Scroll Viewの高さを元の値に戻す
    CGRect viewFrame = [disasterInfoView frame];	
    viewFrame.size.height += keyboardSize.height;
    disasterInfoView.frame = viewFrame;
	
	CGRect frame = disasterInfoView.frame;
	//	scrlView.frame.x = 0;
	frame.origin.x = 0;
	frame.origin.y = 0;
	[disasterInfoView scrollRectToVisible:frame animated:YES];
    self.keyboardShown = FALSE;
	
	disasterInfoView.scrollEnabled = FALSE;

	
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
    self.disasterMemo = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.disasterMemo = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.disasterMemo resignFirstResponder];
    return YES;
}

@end
