//
//  FamilyListViewController.m
//  Scope2
//	(2)世帯一覧画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "FamilyListViewController.h"
#import "CommonTableViewCell.h"
#import "FamiliesInfo.h"
#import "PersonalListViewController.h"

@implementation FamilyListViewController


- (id)initFamilyListView:(GroupsInfo *)selectedClassMng {
	if (self = [super init]) {
		displayId = DISPLAY_ID_02;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		// 組ID設定
		groupId  = [[NSString alloc]initWithString:selectedClassMng.groupId];
		items = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self requestFamily];
	// 地図ボタン作成
	[self createMapButtonInNavicgation];

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
		FamiliesInfo *familiesInfo = (FamiliesInfo *)[items objectAtIndex:0];
		label.text = [NSString stringWithString:familiesInfo.groupName];	
	}
	
	[headerView addSubview:label];
	[label release];
	
	// 行の高さ
	tblView.rowHeight = FAMILY_LIST_TABLE_CELL_HEIGHT;
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
   static NSString *CellIdentifier = @"familyListTableCell";
	
	CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
//		cell = [[[CommonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        // Initialization code
		// 氏名
		cell.cellTitle.frame = CGRectMake(FAMILY_LIST_TABLE_CELL_TITLE_X, 
										  FAMILY_LIST_TABLE_CELL_TITLE_Y, 
										  FAMILY_LIST_TABLE_CELL_TITLE_WIDTH, 
										  FAMILY_LIST_TABLE_CELL_TITLE_HEIGHT);
		cell.cellTitle.font = [UIFont boldSystemFontOfSize:FAMILY_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellTitle];
		
		// 人数
		cell.cellSubTitle.frame = CGRectMake(FAMILY_LIST_TABLE_CELL_SUBTITLE_X, 
											 FAMILY_LIST_TABLE_CELL_SUBTITLE_Y, 
											 FAMILY_LIST_TABLE_CELL_SUBTITLE_WIDTH, 
											 FAMILY_LIST_TABLE_CELL_SUBTITLE_HEIGHT);
		cell.cellSubTitle.font = [UIFont systemFontOfSize:FAMILY_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellSubTitle];

		// 住所
		cell.cellLabel1.frame = CGRectMake(FAMILY_LIST_TABLE_CELL_LABEL1_X, 
										   FAMILY_LIST_TABLE_CELL_LABEL1_Y, 
										   FAMILY_LIST_TABLE_CELL_LABEL1_WIDTH, 
										   FAMILY_LIST_TABLE_CELL_LABEL1_HEIGHT);
		cell.cellLabel1.font = [UIFont systemFontOfSize:FAMILY_LIST_TABLE_CELL_SMALL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellLabel1];
		
		// 電話番号
		cell.cellLabel2.frame = CGRectMake(FAMILY_LIST_TABLE_CELL_LABEL2_X, 
										   FAMILY_LIST_TABLE_CELL_LABEL2_Y, 
										   FAMILY_LIST_TABLE_CELL_LABEL2_WIDTH, 
										   FAMILY_LIST_TABLE_CELL_LABEL2_HEIGHT);
		cell.cellLabel2.font = [UIFont systemFontOfSize:FAMILY_LIST_TABLE_CELL_SMALL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellLabel2];

		cell.cellIcon.frame = CGRectMake(FAMILY_LIST_TABLE_CELL_ICON_X, 
										   FAMILY_LIST_TABLE_CELL_ICON_Y, 
										   FAMILY_LIST_TABLE_CELL_ICON_WIDTH, 
										   FAMILY_LIST_TABLE_CELL_ICON_HEIGHT);
		[cell.contentView addSubview:cell.cellIcon];
	}
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	
	FamiliesInfo *familiesInfo = (FamiliesInfo *)[items objectAtIndex:itemIndex];
	// 世帯名
	[cell.cellTitle setText:[NSString stringWithFormat:@"%@家",familiesInfo.familyName]];
	// 人数
	[cell.cellSubTitle setText:[NSString stringWithFormat:@"%@名",familiesInfo.familyNumber]];
	// 住所
	[cell.cellLabel1 setText:[NSString stringWithFormat:@"%@",familiesInfo.address]];
	// 電話番号
	[cell.cellLabel2 setText:[NSString stringWithFormat:@"%@",familiesInfo.homeTel]];

	// 災害弱者マーク
	if ([familiesInfo.weakKind isEqualToString:@"0"]) {
		[cell.cellIcon setHidden:YES];		
	} else {
		// 災害弱者
		[cell.cellIcon setHidden:NO];
	}

    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// 家族一覧画面へ遷移
	int familyIndex = [indexPath indexAtPosition:[indexPath length] -1];
	FamiliesInfo *familiesInfo = [items objectAtIndex:familyIndex];
	PersonalListViewController *personalListViewController = [[PersonalListViewController alloc] initPersonalListView:familiesInfo];
	[self.navigationController pushViewController:personalListViewController animated:YES];
	[personalListViewController release];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	// TODO とりあえず０件の場合の対応
	if ([items count] < 1) {
		return @"検索結果がありません";
	}
	
	FamiliesInfo *familiesInfo = (FamiliesInfo *)[items objectAtIndex:0];
    switch(section) {
        case 0: // 1個目のセクションの場合
            return familiesInfo.groupName;
            break;
        default: // 2個目のセクションの場合
            return @"";
            break;
    }
    return nil; //ビルド警告回避用
}
*/

/*
 * ヘッダのビュー設定
 */
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.0f,
																   0.0f,
																   320.0f,
																   40.0f)] autorelease];
	[headerView setBackgroundColor:[UIColor blueColor]];
	
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f,
															   0.0f,
															   310.0f,
															   20)];
	// TODO ヘッダカラー
	label.backgroundColor = [UIColor blackColor];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont boldSystemFontOfSize:DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE];

	if ([items count] < 1) {
		label.text = @"検索結果がありません";
	} else {
		FamiliesInfo *familiesInfo = (FamiliesInfo *)[items objectAtIndex:0];
		switch(section) {
			case 0: // 1個目のセクションの場合
				label.text = [NSString stringWithString:familiesInfo.groupName];
				break;
			default: // 2個目のセクションの場合
				//            return @"";
				break;
		}
	}
	[headerView addSubview:label];
	[label release];
	return headerView;
}
*/

#pragma mark -
#pragma mark Data Source
- (void)requestFamily {
	// Table
	NSError *parseError = nil;

	//--------------------------
	// 4.1 世帯一覧取得リクエスト 
	//--------------------------

	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?group_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_FAMILIES"],
					 groupId];
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
	
}


@end
