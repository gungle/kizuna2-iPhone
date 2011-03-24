    //
//  GroupListViewController.m
//  Scope2
//	(1)平常時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "GroupListViewController.h"
#import "FamilyListViewController.h"
#import "GroupsInfo.h"
#import "CommonTableViewCell.h"


@implementation GroupListViewController

- (id)init {
	if (self = [super init]) {
		displayId = DISPLAY_ID_01;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		items = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//	[self requestClass];
	// 行の高さ
	tblView.rowHeight = GROUP_LIST_TABLE_CELL_HEIGHT;
	
}

- (void)viewWillAppear:(BOOL)animated {
	[items removeAllObjects];
	[self requestClass];
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
    static NSString *CellIdentifier = @"groupListTableCell";

	CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (cell == nil) {
//		cell = [[[CommonTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		// Initialization code
		cell.cellTitle.frame = CGRectMake(GROUP_LIST_TABLE_CELL_TITLE_X, 
										  GROUP_LIST_TABLE_CELL_TITLE_Y, 
										  GROUP_LIST_TABLE_CELL_TITLE_WIDTH, 
										  GROUP_LIST_TABLE_CELL_TITLE_HEIGHT);
		cell.cellTitle.font = [UIFont boldSystemFontOfSize:GROUP_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellTitle];
		
		cell.cellSubTitle.frame = CGRectMake(GROUP_LIST_TABLE_CELL_SUBTITLE_X, 
										 GROUP_LIST_TABLE_CELL_SUBTITLE_Y, 
										 GROUP_LIST_TABLE_CELL_SUBTITLE_WIDTH, 
										 GROUP_LIST_TABLE_CELL_SUBTITLE_HEIGHT);
		cell.cellSubTitle.font = [UIFont systemFontOfSize:GROUP_LIST_TABLE_CELL_FONT_SIZE];
		[cell.contentView addSubview:cell.cellSubTitle];
	}
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	
	GroupsInfo *groupsInfo = (GroupsInfo *)[items objectAtIndex:itemIndex];
	// 組名
	[cell.cellTitle setText:[NSString stringWithFormat:@"%@",groupsInfo.groupName]];
	// 世帯数
	[cell.cellSubTitle setText:[NSString stringWithFormat:@"%@世帯",groupsInfo.familyNumber]];

    return cell;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 世帯一覧画面へ遷移
	int groupIndex = [indexPath indexAtPosition:[indexPath length] -1];
	GroupsInfo *groupsInfo = [items objectAtIndex:groupIndex];
	FamilyListViewController *familyListViewController = [[FamilyListViewController alloc] initFamilyListView:groupsInfo];
	[self.navigationController pushViewController:familyListViewController animated:YES];
	[familyListViewController release];
}


#pragma mark -
#pragma mark Data Source
- (void)requestClass {
	// Table
	NSError *parseError = nil;  
	
	//--------------------------
	// 3.1 組一覧取得リクエスト 
	//--------------------------
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_GROUPS"]];
	
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
	
}

@end
