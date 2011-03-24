//
//  PersonalsInformationViewController.m
//  Scope2
//	(4)個人情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "Scope2Properties.h"
#import "AsyncImageView.h"
#import "CommonScrollView.h"
#import "PersonalsInfo.h"

@implementation PersonalInformationViewController


- (id)initPersonalInfoView:(PersonalsInfo *)selectedPersonalMng {
	if (self = [super init]) {
		displayId = DISPLAY_ID_04;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		personalId = [[NSString alloc]initWithString:selectedPersonalMng.personalId];
		personalInfo = [[PersonalsInfo alloc] init];
		items = [[NSMutableArray alloc] initWithCapacity:0];
		// 個人情報XML取得
		[self requestPersonalInformation];
		
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	personalInfo = [items objectAtIndex:0];
	
	CommonScrollView *scrlView = [[CommonScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
	scrlView.pagingEnabled = NO;
	scrlView.contentSize = CGSizeMake(320, 500);
	scrlView.showsHorizontalScrollIndicator = NO;
	scrlView.showsVerticalScrollIndicator = NO;
	scrlView.scrollsToTop = YES;
	self.view = scrlView;
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	UIImageView *userIcon =[[UIImageView alloc] initWithFrame:CGRectMake(PERSONAL_INFO_USER_ICON_X, PERSONAL_INFO_USER_ICON_Y, PERSONAL_INFO_USER_ICON_WIDTH, PERSONAL_INFO_USER_ICON_HEIGHT)];
	AsyncImageView *asyncImageView =[[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, PERSONAL_INFO_USER_ICON_WIDTH, PERSONAL_INFO_USER_ICON_HEIGHT)];
	NSString *imagePath = [[NSString alloc] initWithFormat:@"%@%@", 
#if TARGET_IPHONE_SIMULATOR
															[self getProperties:@"SERVER_DEBUG"],
#else
															[self getProperties:@"SERVER"],
#endif
															personalInfo.iconPath];
	[asyncImageView loadImage:imagePath];
	[userIcon addSubview:asyncImageView];
	[asyncImageView release];
	[scrlView addSubview:userIcon];
	[userIcon release];
	
	//		UIFont *loadingFont = [UIFont systemFontOfSize:PERSONAL_INFO_FONT_SIZE];
	// 氏名ラベル作成
	UILabel *fullNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(PERSONAL_INFO_FULL_NAME_LABEL_X, PERSONAL_INFO_FULL_NAME_LABEL_Y, PERSONAL_INFO_FULL_NAME_LABEL_WIDTH, PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT)];
	fullNameLabel.backgroundColor = [UIColor clearColor];
	fullNameLabel.font = [UIFont boldSystemFontOfSize:PERSONAL_INFO_FONT_SIZE];
	[fullNameLabel setText:personalInfo.fullName];
	[scrlView addSubview:fullNameLabel];
	[fullNameLabel release];
	// 災害弱者マーク作成
	UIImageView *disasterMark = [[UIImageView alloc] initWithFrame:CGRectMake(PERSONAL_INFO_DISASTER_MARK_X, PERSONAL_INFO_DISASTER_MARK_Y, PERSONAL_INFO_DISASTER_MARK_WIDTH, PERSONAL_INFO_DISASTER_MARK_HEIGHT)];
	[disasterMark setImage:[UIImage imageNamed:ICON_NAME_DISASTER_WEAK]];
	[disasterMark setHidden:YES];
	[scrlView addSubview:disasterMark];
	[disasterMark release];
	// 災害弱者マーク
	if ([personalInfo.weakKind isEqualToString:@"1"]) {
		// 災害弱者
		[disasterMark setHidden:NO];
	}
	// 性別ラベル作成
//	UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(PERSONAL_INFO_SEX_LABEL_X, PERSONAL_INFO_SEX_LABEL_Y, PERSONAL_INFO_SEX_LABEL_WIDTH, PERSONAL_INFO_SEX_LABEL_HEIGHT)];
//	sexLabel.backgroundColor = [UIColor clearColor];
//	sexLabel.font = [UIFont systemFontOfSize:PERSONAL_INFO_FONT_SIZE];
//	[sexLabel setText:personalInfo.sex];
//	[scrlView addSubview:sexLabel];
//	[sexLabel release];

	UIImageView *sexIcon = [[UIImageView alloc] initWithFrame:CGRectMake(PERSONAL_INFO_SEX_ICON_X, PERSONAL_INFO_SEX_ICON_Y, PERSONAL_INFO_SEX_ICON_WIDTH, PERSONAL_INFO_SEX_ICON_HEIGHT)];
//	[sexIcon setHidden:YES];
	[scrlView addSubview:sexIcon];
	[sexIcon release];
	if ([personalInfo.sex isEqualToString:@"1"]) {
		[sexIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_MAN]];
	} else if ([personalInfo.sex isEqualToString:@"2"]) {
		[sexIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_WOMAN]];
	}

	
	
	// 年齢ラベル作成
	UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(PERSONAL_INFO_AGE_LABEL_X, PERSONAL_INFO_AGE_LABEL_Y, PERSONAL_INFO_AGE_LABEL_WIDTH, PERSONAL_INFO_AGE_LABEL_HEIGHT)];
	ageLabel.backgroundColor = [UIColor clearColor];
	ageLabel.font = [UIFont systemFontOfSize:PERSONAL_INFO_FONT_SIZE];
	[ageLabel setText:[NSString stringWithFormat:@"%@才", personalInfo.age]];
	[scrlView addSubview:ageLabel];
	[ageLabel release];
	// 血液型ラベル作成
	// 修正事項 2010/11/30 非表示
//	UILabel *bloodLabel = [[UILabel alloc] initWithFrame:CGRectMake(PERSONAL_INFO_BLOOD_LABEL_X, PERSONAL_INFO_BLOOD_LABEL_Y, PERSONAL_INFO_BLOOD_LABEL_WIDTH, PERSONAL_INFO_BLOOD_LABEL_HEIGHT)];
//	bloodLabel.backgroundColor = [UIColor clearColor];
//	bloodLabel.font = [UIFont systemFontOfSize:PERSONAL_INFO_FONT_SIZE];
//	[bloodLabel setText:[NSString stringWithFormat:@"%@型", [self getProperties:@"DIC_BLOOD" propertyName:personalInfo.blood]]];
//	[scrlView addSubview:bloodLabel];	
//	[bloodLabel release];
	// 電話番号ラベル作成
	UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(PERSONAL_INFO_TEL_LABEL_X, PERSONAL_INFO_TEL_LABEL_Y, PERSONAL_INFO_TEL_LABEL_WIDTH, PERSONAL_INFO_TEL_LABEL_HEIGHT)];
	telLabel.backgroundColor = [UIColor clearColor];
	telLabel.font = [UIFont systemFontOfSize:PERSONAL_INFO_FONT_SIZE];
	[telLabel setText:personalInfo.personalTel];
	[scrlView addSubview:telLabel];
	[telLabel release];
	
	// 災害弱者マーク
	if ([personalInfo.weakKind isEqualToString:@"1"]) {
		// 災害弱者
		[disasterMark setHidden:NO];
	}
	
	// テーブル作成
	UITableView *tblView = [[UITableView alloc] initWithFrame:CGRectMake(
															PERSONAL_INFO_TABLE_X, 
															PERSONAL_INFO_TABLE_Y, 
															PERSONAL_INFO_TABLE_WIDTH, 
															PERSONAL_INFO_TABLE_HEIGHT) 
										   style:UITableViewStyleGrouped];
	tblView.delegate = self;
	tblView.dataSource = self;
	[tblView setAllowsSelection:YES];
	[scrlView addSubview:tblView];
	// 行の高さ
	tblView.rowHeight = PERSONAL_INFO_TABLE_CELL_HEIGHT;
	tblView.backgroundColor = [UIColor groupTableViewBackgroundColor];
	[tblView release];
	
	[scrlView release];
	
	// 地図ボタン作成
	[self createMapButtonInNavicgation];
	
	
//	fullNameLabel.backgroundColor = [UIColor cyanColor];
//	ageLabel.backgroundColor = [UIColor cyanColor];
//	bloodLabel.backgroundColor = [UIColor cyanColor];
//	telLabel.backgroundColor = [UIColor cyanColor];
//	userIcon.backgroundColor = [UIColor cyanColor];
//	sexIcon.backgroundColor = [UIColor cyanColor];
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
	[personalInfo  release];
    [super        dealloc];
}

#pragma mark -
#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// セクション数 ２
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"personalTableCell";
	
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        // Initialization code
	}
	
	switch (indexPath.section) {
		case 0:
			cell.textLabel.text = personalInfo.medicalHistory;
			break;
		default:
			cell.textLabel.text = personalInfo.goodField;
			break;
	}
	
	cell.textLabel.numberOfLines = 3;
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0: // 1個目のセクションの場合
            return @"既往歴、弱者情報";
            break;
        case 1: // 2個目のセクションの場合
            return @"得意分野など";
            break;
        default: // それ以外
            return @"";
            break;
    }
    return nil;
}

#pragma mark -
#pragma mark Data Source
- (void)requestPersonalInformation{
	
	// Table
	NSError *parseError = nil;  

	//------------------------------
	// 5.1 個人情報一覧・詳細取得リクエスト 
	//------------------------------
	
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?personal_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_PERSONALS"],
					 personalId];
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];

}

@end
