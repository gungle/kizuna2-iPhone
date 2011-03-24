    //
//  DisasterInfoViewController.m
//  Scope2
//	(12)災害情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/13.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterInfoViewController.h"
#import "DisastersInfo.h"
#import "AsyncImageView.h"
#import "CommonImageView.h"
#import "PhotoViewController.h"



@implementation DisasterInfoViewController

@synthesize disastersInfo;

- (id)initDisasterInfoView:(DisastersInfo *)selectedDisasterMng {
	if (self = [super init]) {
		displayId = DISPLAY_ID_12;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		personalId = [[NSString alloc]initWithString:selectedDisasterMng.personalId];
		items = [[NSMutableArray alloc] initWithCapacity:0];
		// 個人情報XML取得
		[self requestDisasterInfo];
		
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	int tagId = displayId * 100;
	
	DisastersInfo *info = [items objectAtIndex:0];
	
	UIView *disasterInfoView = [[UIView alloc]initWithFrame:[self.view bounds]];
	disasterInfoView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	// 氏名ラベル
	UILabel *fullNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_FULL_NAME_LABEL_X, 
																	   DISASTER_INFO_FULL_NAME_LABEL_Y, 
																	   DISASTER_INFO_FULL_NAME_LABEL_WIDTH, 
																	   DISASTER_INFO_FULL_NAME_LABEL_HEIGHT)];
	fullNameLabel.backgroundColor = [UIColor clearColor];
	fullNameLabel.font = [UIFont boldSystemFontOfSize:DISASTER_INFO_FONT_SIZE];
	[fullNameLabel setText:info.fullName];
	fullNameLabel.tag = tagId;
	[disasterInfoView addSubview:fullNameLabel];
	[fullNameLabel release];
	
	tagId++;
	
//	// 状況
//	UILabel *disasterStausKindLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_X, DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_Y, DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_WIDTH, DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_HEIGHT)];
//	disasterStausKindLabel.backgroundColor = [UIColor clearColor];
//	disasterStausKindLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
//	[disasterStausKindLabel setText:[NSString stringWithFormat:@"状況  %@", [self getProperties:@"DIC_DISASTER_STATUS_KIND" index:[info.disasterStatusKind intValue]]]];
//	disasterStausKindLabel.tag = tagId;
//	[disasterInfoView addSubview:disasterStausKindLabel];
//	[disasterStausKindLabel release];
//	
//	tagId++;
	
	// 緊急度
	UILabel *emergencyKindLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_EMERGENCY_KIND_LABEL_X, 
																			DISASTER_INFO_EMERGENCY_KIND_LABEL_Y, 
																			DISASTER_INFO_EMERGENCY_KIND_LABEL_WIDTH, 
																			DISASTER_INFO_EMERGENCY_KIND_LABEL_HEIGHT)];
	emergencyKindLabel.backgroundColor = [UIColor clearColor];
	emergencyKindLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
	[emergencyKindLabel setText:[NSString stringWithFormat:@"【%@】 %@", 
								 [self getProperties:@"DIC_EMERGENCY_KIND" index:[info.emergencyKind intValue]],
								 [self getProperties:@"DIC_DISASTER_STATUS_KIND" index:[info.disasterStatusKind intValue]]
								 ]];
	emergencyKindLabel.tag = tagId;
	[disasterInfoView addSubview:emergencyKindLabel];
	[emergencyKindLabel release];

	tagId++;
	
	// 災害メモ
/*
	UILabel *disasterMemoLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_DISASTER_MEMO_LABEL_X, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_Y, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_WIDTH, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_HEIGHT)];
	disasterMemoLabel.backgroundColor = [UIColor clearColor];
	disasterMemoLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
	[disasterMemoLabel setText:[NSString stringWithString:info.disasterMemo]];
	disasterMemoLabel.tag = tagId;
	disasterMemoLabel.lineBreakMode = UILineBreakModeTailTruncation;
	disasterMemoLabel.numberOfLines = 4;
	disasterMemoLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
*/
	UITextView *disasterMemoLabel = [[UITextView alloc] initWithFrame:CGRectMake(DISASTER_INFO_DISASTER_MEMO_LABEL_X, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_Y, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_WIDTH, 
																		   DISASTER_INFO_DISASTER_MEMO_LABEL_HEIGHT)];
	disasterMemoLabel.backgroundColor = [UIColor whiteColor];
	disasterMemoLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
	[disasterMemoLabel setText:[NSString stringWithString:info.disasterMemo]];
	disasterMemoLabel.tag = tagId;
	disasterMemoLabel.editable = NO;
	
	[disasterInfoView addSubview:disasterMemoLabel];
	[disasterMemoLabel release];
	
	tagId++;
	
	// 画像
	CommonImageView *picture = [[CommonImageView alloc] initWithFrame:CGRectMake(DISASTER_INFO_PICTURE_X, 
																		 DISASTER_INFO_PICTURE_Y, 
																		 DISASTER_INFO_PICTURE_WIDTH, 
																		 DISASTER_INFO_PICTURE_HEIGHT)];
	
	AsyncImageView *asyncImageView =[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 
																					 0, 
																					 DISASTER_INFO_PICTURE_WIDTH, 
																					 DISASTER_INFO_PICTURE_HEIGHT)];
	
	NSString *imagePath = [[NSString alloc] initWithFormat:@"%@%@", 
#if TARGET_IPHONE_SIMULATOR
															[self getProperties:@"SERVER_DEBUG"],
#else
															[self getProperties:@"SERVER"],
#endif
															info.picturePath];
	[asyncImageView loadImage:imagePath mode:1];
	
	
	[picture addSubview:asyncImageView];
	[asyncImageView release];
	picture.tag = tagId;
	[disasterInfoView addSubview:picture];
	[picture release];
	
	tagId++;

	
	// トリアージラベル
	UILabel *triageLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_TRIAGE_LABEL_X, 
																	 DISASTER_INFO_TRIAGE_LABEL_Y, 
																	 DISASTER_INFO_TRIAGE_LABEL_WIDTH, 
																	 DISASTER_INFO_TRIAGE_LABEL_HEIGHT)];
	triageLabel.backgroundColor = [UIColor clearColor];
	triageLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
	[triageLabel setText:@"トリアージ"];
	triageLabel.tag = tagId;
	[disasterInfoView addSubview:triageLabel];
	[triageLabel release];
	
	tagId++;

	// トリアージ（セグメント）
	UISegmentedControl *triageSeg = [[UISegmentedControl alloc] initWithItems:nil];
	triageSeg.segmentedControlStyle = UISegmentedControlStyleBar;
	[triageSeg setBackgroundColor:[UIColor clearColor]];
//	[triageSeg setTintColor:[UIColor orangeColor]];
	[triageSeg setFrame:CGRectMake(DISASTER_INFO_TRIAGE_X, 
								   DISASTER_INFO_TRIAGE_Y, 
								   DISASTER_INFO_TRIAGE_WIDTH, 
								   DISASTER_INFO_TRIAGE_HEIGHT)];
	triageSeg.momentary = NO;
	[triageSeg insertSegmentWithImage:[UIImage imageNamed:ICON_NAME_TRIAGE_WHITE]  atIndex:0 animated:(BOOL)YES];
	[triageSeg insertSegmentWithImage:[UIImage imageNamed:ICON_NAME_TRIAGE_GREEN]  atIndex:1 animated:(BOOL)YES];
	[triageSeg insertSegmentWithImage:[UIImage imageNamed:ICON_NAME_TRIAGE_YELLOW] atIndex:2 animated:(BOOL)YES];
	[triageSeg insertSegmentWithImage:[UIImage imageNamed:ICON_NAME_TRIAGE_RED]    atIndex:3 animated:(BOOL)YES];
	[triageSeg insertSegmentWithImage:[UIImage imageNamed:ICON_NAME_TRIAGE_BLACK]  atIndex:4 animated:(BOOL)YES];
	triageSeg.selectedSegmentIndex = [info.triageKind intValue];
	triageTag = tagId;
	triageSeg.tag = triageTag;
//	[triageSeg addTarget:self action:@selector(changeTriage:) forControlEvents:UIControlEventValueChanged];
	[disasterInfoView addSubview:triageSeg];
	
	tagId++;

	// 対応完了ラベル
//	UILabel *doneLabel = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_INFO_FULL_NAME_LABEL_X, DISASTER_INFO_FULL_NAME_LABEL_Y, DISASTER_INFO_FULL_NAME_LABEL_WIDTH, DISASTER_INFO_FULL_NAME_LABEL_HEIGHT)];
//	doneLabel.backgroundColor = [UIColor clearColor];
//	doneLabel.font = [UIFont boldSystemFontOfSize:DISASTER_INFO_FONT_SIZE];
//	[doneLabel setText:@"対応完了"];
//	[disasterInfoView addSubview:doneLabel];
//	[doneLabel release];
	// 対応完了チェック（セグメント）
	UISegmentedControl *doneSeg = [[UISegmentedControl alloc] initWithItems:nil];
	doneSeg.segmentedControlStyle = UISegmentedControlStyleBar;
	[doneSeg setBackgroundColor:[UIColor clearColor]];
	[doneSeg setFrame:CGRectMake(DISASTER_INFO_DONE_KIND_X, 
								 DISASTER_INFO_DONE_KIND_Y, 
								 DISASTER_INFO_DONE_KIND_WIDTH, 
								 DISASTER_INFO_DONE_KIND_HEIGHT)];
	doneSeg.momentary = NO;
	
	[doneSeg insertSegmentWithTitle:[self getProperties:@"DIC_DONE_KIND" indexName:0] atIndex:0 animated:YES];
	[doneSeg insertSegmentWithTitle:[self getProperties:@"DIC_DONE_KIND" indexName:1] atIndex:1 animated:YES];
	doneSeg.selectedSegmentIndex = [info.doneKind intValue];
	doneKindTag = tagId;
	doneSeg.tag = doneKindTag;
	[disasterInfoView addSubview:doneSeg];
	
	tagId++;
	
	// 更新ボタン
	UIButton *updateButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	updateButton.frame = CGRectMake(DISASTER_INFO_UPDATE_BUTTON_X, 
									DISASTER_INFO_UPDATE_BUTTON_Y, 
									DISASTER_INFO_UPDATE_BUTTON_WIDTH, 
									DISASTER_INFO_UPDATE_BUTTON_HEIGHT);
	updateButton.titleLabel.font = [UIFont systemFontOfSize:DISASTER_INFO_FONT_SMALL_SIZE];
	// 通常状態
//	[updateButton setBackgroundImage:[UIImage imageNamed:@".png"] forState:UIControlStateNormal];
	[updateButton setTitle:@"更新" forState:UIControlStateNormal];
	// アクション
	[updateButton addTarget:self action:@selector(pushUpdateButton:) forControlEvents:UIControlEventTouchUpInside];	
	updateButton.tag = tagId;
	[disasterInfoView addSubview:updateButton];
	[updateButton release];
	
	tagId++;
	
	// 地図ボタン
	[self createMapButtonInNavicgation];
	
	
//	fullNameLabel.backgroundColor = [UIColor cyanColor];
//	emergencyKindLabel.backgroundColor = [UIColor magentaColor];
//	disasterMemoLabel.backgroundColor = [UIColor yellowColor];
//	triageLabel.backgroundColor = [UIColor greenColor];
	
	
	self.view = disasterInfoView;
	[disasterInfoView release];
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
	[disastersInfo release];
    [super dealloc];
}

- (void)requestDisasterInfo {
	// Table
	NSError *parseError = nil;
	
	//--------------------------
	// 7.2 災害情報詳細取得リクエスト 
	//--------------------------

	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?personal_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_DISASTERS"],
					 personalId];
	
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];

}

#pragma mark -
#pragma mark action
- (void)pushUpdateButton:(id)sender {
	NSInteger selectedTriage = 0;
	NSInteger selectedDoneKind = 0;
	
	for (UIView *addView in self.view.subviews) {
		if (addView.tag == triageTag) {
			// トリアージ取得
			selectedTriage = ((UISegmentedControl*)addView).selectedSegmentIndex;

		} else if (addView.tag == doneKindTag) {
			// 対応状態取得
			selectedDoneKind = ((UISegmentedControl*)addView).selectedSegmentIndex;
//			if (doneKindIndex == 0) {
//				// 対応が選択されている
//				selectedDoneKind = 1;
//			} else {
//				// 未対応が選択されている（または選択されていない？）
//				selectedDoneKind = 0;
//			}
		}
	}
	
	// 更新処理
	[self putData:selectedTriage doneKind:selectedDoneKind];
}

- (void)putData:(NSInteger)triage doneKind:(NSInteger)doneKind {
	static NSString* const BOUNDARY = @"scopeproject2010----------";
	
	//-----------------------
	// 7.4 災害情報更新リクエスト 
	//-----------------------
	
	NSString *url = [NSString stringWithFormat:@"%@%@/%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_DISASTERS_POST"],
					 personalId];
	NSLog(@"---- > %@",url);
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"PUT"];
	NSString *contentType = [NSString stringWithFormat:@"application/xml; boundary=%@",BOUNDARY];	

 	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_DISASTER] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_TRIAGE_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%d",triage] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_TRIAGE_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_DONE_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"%d",doneKind] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_DONE_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_DISASTER] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	
	// URLコネクションを作る
	[NSURLConnection connectionWithRequest:request delegate:self];
	
}

- (void)connection:(NSURLConnection*)connection
	didReceiveData:(NSData*)data
{
	char* p = (char*)[data bytes];
	int len = [data length];
	while (len-- > 0) {
		putchar(*p++);
	}
	//	NSLog(@"%@",data);
	 // XML解析
	 NSError *parseError = nil;
	 [self parseXMLFileAtData:data parseError:&parseError];

	// error判定
	 if ([results isEqualToString:@"NG"]) {
		 [self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
				 message:[NSString stringWithFormat:@"%@の更新に失敗しました",[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			   okBtnName:@"OK"];
	 } else {
		 [self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
				 message:[NSString stringWithFormat:@"%@の更新に成功しました",[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			   okBtnName:@"OK"];
	 }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	
	if ([[touch view] isKindOfClass:CommonImageView.class]) {
		
		DisastersInfo *info = [items objectAtIndex:0];
		NSString *imagePath = [[NSString alloc] initWithFormat:@"%@%@", 
#if TARGET_IPHONE_SIMULATOR
							   [self getProperties:@"SERVER_DEBUG"],
#else
							   [self getProperties:@"SERVER"],
#endif
							   info.picturePath];
		
//		AsyncImageView *ai = (AsyncImageView *)[touch view];
		PhotoViewController *photoViewController = [[PhotoViewController alloc] initWithImagePath:imagePath];
		[self.navigationController pushViewController:photoViewController animated:YES];
		[photoViewController release];
	}
	
}


@end
