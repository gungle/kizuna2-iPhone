    //
//  PersonalListViewController.m
//  Scope2
//	(3)家族一覧画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/02.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalListViewController.h"
#import "CommonTableViewCell.h"
#import "PersonalInformationViewController.h"
#import "PersonalsInfo.h"

@implementation PersonalListViewController

@synthesize tblView;

- (id)initPersonalListView:(FamiliesInfo *)selectedFamilMng {
	if (self = [super init]) {
		displayId = DISPLAY_ID_03;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		
		familyId   = [[NSString alloc]initWithString:selectedFamilMng.familyId];
		items = [[NSMutableArray alloc] initWithCapacity:0];
		[self requestPersonal];

	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	tblView = [[UITableView alloc] initWithFrame:CGRectMake(DEFAULT_TABLE_X,
															DEFAULT_TABLE_Y,
															DEFAULT_TABLE_WIDTH,
															DEFAULT_TABLE_HEIGHT)
										   style:UITableViewStyleGrouped];
	tblView.delegate = self;
	tblView.dataSource = self;
	[tblView setAllowsSelection:YES];
	[self.view addSubview:tblView];
	
	
	// ヘッダの高さ
	UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f,
																   0.0f,
																   320.0f,
																   35.0f)] autorelease];
	headerView.backgroundColor = [UIColor clearColor];
	//	GRect frame = self.headerView.frame;
	//	frame.size.height = 50.0;
	tblView.tableHeaderView.frame = headerView.frame;
	tblView.tableHeaderView = nil;
	tblView.tableHeaderView = headerView;
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
															   10.0f,
															   310.0f,
															   25.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor darkGrayColor];
	label.shadowColor = [UIColor whiteColor];
	label.font = [UIFont boldSystemFontOfSize:DEFAULT_FONT_SIZE];

	if ([items count] < 1) {
		label.text = @"検索結果がありません";	
	} else {
		PersonalsInfo *info = (PersonalsInfo *)[items objectAtIndex:0];
		label.text = [NSString stringWithFormat:@"%@家",info.familyName];	
	}
	
	[headerView addSubview:label];
	[label release];
	
	// 行の高さ
	tblView.rowHeight = PERSONAL_LIST_TABLE_CELL_HEIGHT;
	// 地図ボタン作成
	[self createMapButtonInNavicgation];
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
	[tblView release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"personalListTableCell";
	
	CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
//		cell = [[[CommonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        // Initialization code
		// 氏名
		cell.cellTitle.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_TITLE_X, 
										  PERSONAL_LIST_TABLE_CELL_TITLE_Y, 
										  PERSONAL_LIST_TABLE_CELL_TITLE_WIDTH, 
										  PERSONAL_LIST_TABLE_CELL_TITLE_HEIGHT);
		cell.cellTitle.font = [UIFont boldSystemFontOfSize:PERSONAL_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellTitle];
		
		// 性別
//		cell.cellSubTitle.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_SUBTITLE_X, 
//											 PERSONAL_LIST_TABLE_CELL_SUBTITLE_Y, 
//											 PERSONAL_LIST_TABLE_CELL_SUBTITLE_WIDTH, 
//											 PERSONAL_LIST_TABLE_CELL_SUBTITLE_HEIGHT);
//		cell.cellSubTitle.font = [UIFont systemFontOfSize:PERSONAL_LIST_TABLE_CELL_FONT_SIZE];
//		[cell.contentView addSubview:cell.cellSubTitle];
//		
		cell.cellManIcon.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_SEX_ICON_X, 
										 PERSONAL_LIST_TABLE_CELL_SEX_ICON_Y, 
										 PERSONAL_LIST_TABLE_CELL_SEX_ICON_WIDTH, 
										 PERSONAL_LIST_TABLE_CELL_SEX_ICON_HEIGHT);
		[cell.contentView addSubview:cell.cellManIcon];
		[cell.cellManIcon setHidden:YES];
		cell.cellWomanIcon.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_SEX_ICON_X, 
											PERSONAL_LIST_TABLE_CELL_SEX_ICON_Y, 
											PERSONAL_LIST_TABLE_CELL_SEX_ICON_WIDTH, 
											PERSONAL_LIST_TABLE_CELL_SEX_ICON_HEIGHT);
		[cell.contentView addSubview:cell.cellWomanIcon];
		[cell.cellWomanIcon setHidden:YES];
		
		
		// 年齢
		cell.cellLabel1.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_LABEL1_X, 
										   PERSONAL_LIST_TABLE_CELL_LABEL1_Y, 
										   PERSONAL_LIST_TABLE_CELL_LABEL1_WIDTH, 
										   PERSONAL_LIST_TABLE_CELL_LABEL1_HEIGHT);
		cell.cellLabel1.font = [UIFont systemFontOfSize:PERSONAL_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellLabel1];

		// 災害弱者マーク
		cell.cellIcon.frame = CGRectMake(PERSONAL_LIST_TABLE_CELL_ICON_X, 
										 PERSONAL_LIST_TABLE_CELL_ICON_Y, 
										 PERSONAL_LIST_TABLE_CELL_ICON_WIDTH, 
										 PERSONAL_LIST_TABLE_CELL_ICON_HEIGHT);
		[cell.contentView addSubview:cell.cellIcon];
	}
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	
	PersonalsInfo *mng = (PersonalsInfo *)[items objectAtIndex:itemIndex];
	// 氏名
	[cell.cellTitle setText:[NSString stringWithFormat:@"%@",mng.fullName]];
	// 性別
//	[cell.cellSubTitle setText:[NSString stringWithFormat:@"(%@)",mng.sex]];
	if ([mng.sex isEqualToString:@"1"]) {
		[cell.cellManIcon setHidden:NO];
	} else if ([mng.sex isEqualToString:@"2"]) {
		[cell.cellWomanIcon setHidden:NO];
	}

	// 年齢
	[cell.cellLabel1 setText:[NSString stringWithFormat:@"%@才",mng.age]];

	
	// 災害弱者マーク
	if ([mng.weakKind isEqualToString:@"0"]) {
		[cell.cellIcon setHidden:YES];		
	} else {
		// 災害弱者
		[cell.cellIcon setHidden:NO];
	}
	
    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 個人情報画面へ遷移
	int personalIndex = [indexPath indexAtPosition:[indexPath length] -1];
	PersonalsInfo *mng = [items objectAtIndex:personalIndex];
	
	// 2011/11/01 追加事項
	// 個人情報アクセス制御
	// 平常時：アクセス権がないと個人情報を参照できない
	//       アラート表示して個人情報画面に遷移しない
	// 災害時：参照可能
	// アクセス制御(access_kind)
	// 0:閲覧NG
	// 1:閲覧OK
	if (mng.accessKind != nil
		&& ![mng.accessKind isEqualToString:@""]
		&& [mng.accessKind isEqualToString:@"0"]) {
		// アラート
		[self alertView:@"" message:@"他組の情報を見ることはできません" okBtnName:@"OK"];
	} else {
		PersonalInformationViewController *personalInfoViewController = [[PersonalInformationViewController alloc] initPersonalInfoView:mng];
		[self.navigationController pushViewController:personalInfoViewController animated:YES];
		[personalInfoViewController release];
	}
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	// TODO とりあえず０件の場合の対応
	if ([items count] < 1) {
		return @"検索結果がありません";
	}
	
	PersonalsInfo *info = (PersonalsInfo *)[items objectAtIndex:0];

    switch(section) {
        case 0: // 1個目のセクションの場合
            return [NSString stringWithFormat:@"%@家",info.familyName];
            break;
        default: // 2個目のセクションの場合
            return @"";
            break;
    }
    return nil;
}
*/
#pragma mark -
#pragma mark Data Source
- (void)requestPersonal {
	
	// Table
	NSError *parseError = nil;  

	//------------------------------
	// 5.1 個人情報一覧・詳細取得リクエスト 
	//------------------------------
	// 2011/11/01 追加事項
	// 個人情報アクセス制御
	// 平常時：アクセス権がないと個人情報を参照できない
	// 災害時：参照可能
	// 家族一覧画面表示時にアクセス権を取得する（5.1個人情報一覧・取得APIに追加）
	// 平常時のURLのパラメタにaccess=onを追加
	
	NSString *accessKind;
	if ([self getTabSelectedIndex] == 0) {
		// 平常時の場合
		accessKind = @"&access=on";
	} else {
		accessKind = @"";
	}


	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?family_id=%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_PERSONALS"],
					 familyId,
					 accessKind];
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
	
}


@end
