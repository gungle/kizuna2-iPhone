//
//  DisasterListViewController.m
//  Scope2
//	(11)災害時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterListViewController.h"
#import "DisasterListViewCell.h"
#import "DisasterInfoViewController.h"
#import "PersonalInformationViewController.h"
#import "PersonalListViewController.h"
#import "DisasterInfoSendViewController.h"
#import "SafetyConfirmViewController.h"
#import "DisastersInfo.h"
#import "DisasterData.h"


@implementation DisasterListViewController

@synthesize xmlGroupId;
@synthesize xmlGroupName;
@synthesize triggerHeader;
@synthesize imageView;

- (id)init {
	if (self = [super initWithTableViewStylePlain]) {
		displayId = DISPLAY_ID_11;
		// タイトル削除 2010/11/05 災害情報共有ボタン追加のため
//		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		items = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	tblView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	// テーブルをプルダウンして更新（2010/11/02追加）
	CGRect r = tblView.bounds;
	r.origin.y -= DISASTER_LIST_TABLE_TRIGGER_HEIGHT;
	r.size.height = DISASTER_LIST_TABLE_TRIGGER_HEIGHT;
	UIView *headerView = [[UIView alloc]initWithFrame:r];
	headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	triggerHeader = [[UILabel alloc] initWithFrame:CGRectMake((r.size.width - DISASTER_LIST_TABLE_TRIGGER_WIDTH) / 2,
																0.0,
																DISASTER_LIST_TABLE_TRIGGER_WIDTH,
																DISASTER_LIST_TABLE_TRIGGER_HEIGHT)];
	triggerHeader.font = [UIFont systemFontOfSize:12];
	triggerHeader.backgroundColor = [UIColor clearColor];
	triggerHeader.text = @"ドラッグして更新...";
	[headerView addSubview:triggerHeader];
	
	imageView = [[UIImageView alloc]
							  initWithFrame:CGRectMake(DISASTER_LIST_TRIGGER_ARROW_X,
													   DISASTER_LIST_TRIGGER_ARROW_Y,
													   DISASTER_LIST_TRIGGER_ARROW_WIDTH,
													   DISASTER_LIST_TRIGGER_ARROW_HEIGHT)];
	imageView.image = [UIImage imageNamed:ICON_NAME_ARROW];
	imageView.backgroundColor = [UIColor clearColor];
	[headerView addSubview:imageView];
	headerOn = NO;
	[tblView addSubview:headerView];
	[headerView release];
	
	
	UIView *toolbarView = [[UIView alloc] initWithFrame:CGRectMake(DISASTER_LIST_TABLE_TOOLBAR_VIEW_X,
															   DISASTER_LIST_TABLE_TOOLBAR_VIEW_Y,
															   DISASTER_LIST_TABLE_TOOLBAR_WIDTH,
															   DISASTER_LIST_TABLE_TOOLBAR_HEIGHT)];
	toolbarView.backgroundColor = [UIColor clearColor];
	
	
	UIToolbar *leftToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(DISASTER_LIST_TABLE_TOOLBAR_X,
																	 DISASTER_LIST_TABLE_TOOLBAR_Y,
																	 DISASTER_LIST_TABLE_TOOLBAR_WIDTH,
																	 DISASTER_LIST_TABLE_TOOLBAR_HEIGHT)];
	leftToolbar.backgroundColor = [UIColor clearColor];
	leftToolbar.barStyle = UIBarStyleDefault;
	// 安否入力ボタン作成
	UIBarButtonItem *naviButton1 = [[UIBarButtonItem alloc] 
									initWithTitle:@"安否確認"
									style:UIBarButtonItemStyleBordered
									target:self
									action:@selector(pushSafetyInputButton:)];
	// 被災者入力ボタン作成
	UIBarButtonItem *naviButton2 = [[UIBarButtonItem alloc] 
									initWithTitle:@"被災者入力"
									style:UIBarButtonItemStyleBordered
									target:self
									action:@selector(pushVictimInputButton:)];	
	
	//Ajputer un espace flexible pour l'espacement entre les boutons
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	
	// 災害情報共有ボタン作成
	UIBarButtonItem *naviButton3 = [[UIBarButtonItem alloc] 
									initWithTitle:@"被害情報発信"
									style:UIBarButtonItemStyleBordered
									target:self
									action:@selector(pushDisasterInfoShareButton:)];	
	
	NSArray *elements = [NSArray arrayWithObjects:naviButton1,
						 flexible,
						 naviButton2,
						 flexible,
						 naviButton3,
						 flexible,
						 nil];
	
    [leftToolbar setItems:elements animated:NO];
	
	[toolbarView addSubview:leftToolbar];
	[leftToolbar release];
	
	
	UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbarView];
	self.navigationItem.leftBarButtonItem = leftBarButtonItem;
	[toolbarView release];

	
	
	[self createMapButtonInNavicgation];
    [naviButton1 release];
    [naviButton2 release];
    [naviButton3 release];
    [flexible release];
	
	
	// 行の高さ
	tblView.rowHeight = DISASTER_LIST_TABLE_CELL_HEIGHT;
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// 更新後の再表示対応
	[items removeAllObjects];
	[self requestDisaster];
	[tblView reloadData];
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
	[items removeAllObjects];
	[items release];
	[triggerHeader release];
	[imageView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {               // any offset changes
	CGRect r = tblView.bounds;
	[UIView beginAnimations:nil context:nil];
	if ((r.origin.y < -DISASTER_LIST_OFFSET_Y) && (headerOn == NO)) {
		headerOn = YES;
		imageView.transform = CGAffineTransformRotate(
													  CGAffineTransformIdentity, 3.14);
		triggerHeader.text = [NSString stringWithFormat:@"リリースして更新", r.origin.y];
	}
	if ((r.origin.y > -DISASTER_LIST_OFFSET_Y) && (headerOn == YES)) {
		headerOn = NO;
		imageView.transform = CGAffineTransformRotate(
													  CGAffineTransformIdentity, 0.0);
		triggerHeader.text = [NSString stringWithFormat:@"ドラッグして更新...", r.origin.y];
	}
	[UIView commitAnimations];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//	NSLog(@"scrollViewWillBeginDecelerating");
	CGRect r = tblView.bounds;
	if ((r.origin.y < -DISASTER_LIST_OFFSET_Y) && (headerOn == YES)) {
		triggerHeader.text = @"更新中";
		tblView.delaysContentTouches = NO;
		[items removeAllObjects];
		[self requestDisaster];
		[tblView reloadData];
	}
}
/*
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	NSLog(@"scrollViewDidEndDragging %d",decelerate);
}
*/

#pragma mark -
#pragma mark UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [items count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	DisasterData *data = (DisasterData *)[items objectAtIndex:section];
	return [data.subItems count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"disasterListTableCell";
	
	DisasterListViewCell *cell = (DisasterListViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[DisasterListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        // Initialization code
	}
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	NSInteger section = indexPath.section;
	
	[items objectAtIndex:section];
	DisasterData *data = (DisasterData *)[items objectAtIndex:section];
	DisastersInfo *info = (DisastersInfo *)[data.subItems objectAtIndex:itemIndex];
	

	// テキストカラー
	UIColor *textColor = [UIColor blackColor];
	// バックグラウンドカラー
	UIColor *bgColor = [UIColor whiteColor];
	// タイトル(氏名または家族名）
	NSString *titleName;

	if ([data.sectionKind isEqualToString:@"0"]) {
		// 安否状況 かつ 安否不明者 → 紫
		if ([info.safetyMode isEqualToString:@"1"]) {
			
			// 個人
			//背景色
			if ([info.personalSafetyKind isEqualToString:@"2"]) {
				// ケガ、不明など
				bgColor = DISASTER_LIST_TABLE_CELL_COLOR_SAFETY_MODE_1;
			}
			
			titleName = [NSString stringWithString:info.fullName];			
			// 氏名
			[cell.cellFullName setText:[NSString stringWithFormat:@"%@",titleName]];
			// 個人安否種別
			[cell.cellExplain setText:[NSString stringWithFormat:@"%@",[self getProperties:@"DIC_PERSONAL_SAFETY_KIND" propertyName:info.personalSafetyKind]]];
			// 性別
//			[cell.cellSex setText:[NSString stringWithFormat:@"%@",info.sex]];
			if ([info.sex isEqualToString:@"1"]) {
				[cell.cellManIcon setHidden:NO];
				[cell.cellWomanIcon setHidden:YES];
			} else if ([info.sex isEqualToString:@"2"]) {
				[cell.cellManIcon setHidden:YES];
				[cell.cellWomanIcon setHidden:NO];
			}
			// 年齢
			[cell.cellAge setText:[NSString stringWithFormat:@"%@",info.age]];
		} else {
			// 家族
			//背景色
			bgColor = DISASTER_LIST_TABLE_CELL_COLOR_SAFETY_MODE_2;
			//bgColor = [UIColor purpleColor];
			//textColor = [UIColor whiteColor];

			titleName = [NSString stringWithString:info.familyName];			
			// 氏名
			[cell.cellFullName setText:[NSString stringWithFormat:@"%@",titleName]];
			// 家族安否通知種別
			[cell.cellExplain setText:[NSString stringWithFormat:@"%@",[self getProperties:@"DIC_FAMILY_SAFETY_KIND" propertyName:info.status]]];
			
			// 性別
			[cell.cellManIcon setHidden:YES];
			[cell.cellWomanIcon setHidden:YES];
			// 年齢
			[cell.cellAge setText:@""];
		}
		
	} else if ([data.sectionKind isEqualToString:@"1"]) {
		titleName = [NSString stringWithString:info.fullName];			
		// 被災者情報 かつ トリアージ 0　以外 → トリアージの色（定義する必要あり）
		if ([info.triageKind isEqualToString:@"1"]) {
			bgColor = DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_1;
		} else if ([info.triageKind isEqualToString:@"2"]) {
			bgColor = DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_2;
		} else if ([info.triageKind isEqualToString:@"3"]) {
			bgColor = DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_3;
		} else if ([info.triageKind isEqualToString:@"4"]) {
			bgColor = DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_4;
		}
		// 氏名
		[cell.cellFullName setText:[NSString stringWithFormat:@"%@",titleName]];
		// 緊急度
		NSString *emergency = [NSString stringWithString:[self getProperties:@"DIC_EMERGENCY_KIND" index:[info.emergencyKind intValue]]];
		NSString *disasterStatus = [NSString stringWithString:[self getProperties:@"DIC_DISASTER_STATUS_KIND" index:[info.disasterStatusKind intValue]]];
		// 災害状況
		[cell.cellExplain setText:[NSString stringWithFormat:@"【%@】%@", emergency, disasterStatus]];
		
		// 性別
//		[cell.cellSex setText:[NSString stringWithFormat:@"%@",info.sex]];
		if ([info.sex isEqualToString:@"1"]) {
			[cell.cellManIcon setHidden:NO];
			[cell.cellWomanIcon setHidden:YES];
		} else if ([info.sex isEqualToString:@"2"]) {
			[cell.cellManIcon setHidden:YES];
			[cell.cellWomanIcon setHidden:NO];
		}
		// 年齢
		[cell.cellAge setText:[NSString stringWithFormat:@"%@",info.age]];
	} else {
		titleName = [NSString stringWithString:info.fullName];			
		// 氏名
		[cell.cellFullName setText:[NSString stringWithFormat:@"%@",titleName]];
		// 性別
//		[cell.cellSex setText:[NSString stringWithFormat:@"%@",info.sex]];
		if ([info.sex isEqualToString:@"1"]) {
			[cell.cellManIcon setHidden:NO];
			[cell.cellWomanIcon setHidden:YES];
		} else if ([info.sex isEqualToString:@"2"]) {
			[cell.cellManIcon setHidden:YES];
			[cell.cellWomanIcon setHidden:NO];
		}
		// 年齢
		[cell.cellAge setText:[NSString stringWithFormat:@"%@",info.age]];
		
		// 初期化
		[cell.cellExplain setText:@""];
	}

	// 災害メモ
	[cell.cellMemo setText:info.disasterMemo];
	
	
	cell.bgView.backgroundColor = bgColor;
	cell.cellFullName.textColor = textColor;
	cell.cellExplain.textColor  = textColor;
	cell.cellSex.textColor      = textColor;
	cell.cellAge.textColor      = textColor;
	cell.cellMemo.textColor     = textColor;
	cell.cellFullName.backgroundColor = bgColor;
	cell.cellExplain.backgroundColor  = bgColor;
	cell.cellSex.backgroundColor      = bgColor;
	cell.cellAge.backgroundColor      = bgColor;
	cell.cellMemo.backgroundColor     = bgColor;

	
	// 対応マーク
	if ([data.sectionKind isEqualToString:@"0"]) {
		// 安否状況
		// チェックボックス非表示 2010/10/19
		[cell.cellCheckImage setHidden:YES];		
		[cell.cellNonCheckImage setHidden:YES];
	} else {
		if ([info.doneKind isEqualToString:@"0"]) {
			[cell.cellCheckImage setHidden:YES];		
			[cell.cellNonCheckImage setHidden:NO];
		} else {
			[cell.cellCheckImage setHidden:NO];
			[cell.cellNonCheckImage setHidden:YES];
		}
	}

    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	NSInteger section = indexPath.section;
	
	[items objectAtIndex:section];
	DisasterData *data = (DisasterData *)[items objectAtIndex:section];
	DisastersInfo *info = (DisastersInfo *)[data.subItems objectAtIndex:itemIndex];
	
	if ([data.sectionKind isEqualToString:@"1"]) {
		// 被災者情報の場合
		// 災害情報画面へ遷移
		DisasterInfoViewController *disasterInfoViewController = [[DisasterInfoViewController alloc] initDisasterInfoView:info];
		[self.navigationController pushViewController:disasterInfoViewController animated:YES];
		[disasterInfoViewController release];

	} else {
		// 被災者情報ではない場合
		if ([data.sectionKind isEqualToString:@"0"] && [info.safetyMode isEqualToString:@"2"]) {
			// 安否情報の個人（未回答）
			// 家族一覧画面へ遷移
			PersonalListViewController *personalListViewController = [[PersonalListViewController alloc] initPersonalListView:info];
			[self.navigationController pushViewController:personalListViewController animated:YES];
			[personalListViewController release];
		} else {
			// 安否情報の個人（回答済み）または災害弱者情報
			// 個人情報画面へ遷移
			PersonalInformationViewController *personalInfoViewController = [[PersonalInformationViewController alloc] initPersonalInfoView:info];
			[self.navigationController pushViewController:personalInfoViewController animated:YES];
			[personalInfoViewController release];
		}

	}

}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	DisasterData *data = (DisasterData *)[items objectAtIndex:section];
	NSString *status = nil;
	if ([data.sectionKind isEqualToString:@"0"]) {
		// 安否状況
		status = @"安否状況";
	} else if ([data.sectionKind isEqualToString:@"1"]) {
		status = @"被災者情報";
	} else {
		status = @"災害弱者情報";
	}
	
    return [NSString stringWithFormat:@"%@ %@", data.groupName, status];
}
*/

/*
 * ヘッダのビュー設定
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[[UIView alloc] init] autorelease];
	[headerView setBackgroundColor:[UIColor darkGrayColor]];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
															   0.0f,
															   310.0f,
															   DISASTER_LIST_TABLE_HEADER_HEIGHT)];
	// TODO ヘッダカラー
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont boldSystemFontOfSize:DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE];
	DisasterData *data = (DisasterData *)[items objectAtIndex:section];
	NSString *status = nil;
	if ([data.sectionKind isEqualToString:@"0"]) {
		status = @"安否状況";
	} else if ([data.sectionKind isEqualToString:@"1"]) {
		status = @"被害状況";
	} else {
		status = @"災害弱者情報";
	}
	label.text = [NSString stringWithFormat:@"%@ %@", data.groupName, status];
	[headerView addSubview:label];
	[label release];
	return headerView;
}

/*
 * ヘッダの高さ設定
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return DISASTER_LIST_TABLE_HEADER_HEIGHT;
}

#pragma mark -
#pragma mark Data Source
- (void)requestDisaster {
	NSError *parseError = nil;
	
	//--------------------------
	// 7.1 災害一覧取得リクエスト 
	//--------------------------
	
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_DISASTERS"]];
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
}

#pragma mark -
#pragma mark Button Action
- (void)pushSafetyInputButton:(id)sender {
	// 安否入力画面へ遷移
	SafetyConfirmViewController *safetyConfirmViewController = [[SafetyConfirmViewController alloc] initSafetyConfirmView];
	[self.navigationController pushViewController:safetyConfirmViewController animated:YES];
	[safetyConfirmViewController release];
	
}
- (void)pushVictimInputButton:(id)sender {
	// 被災者情報入力画面へ遷移
	DisasterInfoSendViewController *disasterInfoSendViewController = [[DisasterInfoSendViewController alloc] initDisasterInfoSendView:nil];
	[self.navigationController pushViewController:disasterInfoSendViewController animated:YES];
	[disasterInfoSendViewController release];
}


- (void)pushDisasterInfoShareButton:(id)sender {
	//-----------------------
	// 7.5 災害情報共有リクエスト 
	//-----------------------
	// 組ID設定
	[self setGroupId];
	
	NSString *url = [NSString stringWithFormat:@"%@%@?group_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_SHARE_DISASTERS_GET"],
					 groupId];
	NSLog(@"---- > %@",url);
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"GET"];
	
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
		[self alertView:[NSString stringWithString:@"被害情報のお知らせ"]
				message:[NSString stringWithString:@"災害情報共有に失敗しました"]
			  okBtnName:@"OK"];
	} else {
		// 修正事項 2010/11/30 非表示
//		[self alertView:[NSString stringWithString:@"被害情報のお知らせ"]
//				message:[NSString stringWithString:@"他の組に被害情報が伝わりました"]
//			  okBtnName:@"OK"];
	}

}

@end
