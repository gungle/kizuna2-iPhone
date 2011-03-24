//
//  SafetyConfirmViewController.m
//  Scope2
//	(14)安否確認画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "SafetyConfirmViewController.h"
#import "SafetyConfirmViewCell.h"
#import "PersonalsInfo.h"

@implementation SafetyConfirmViewController

@synthesize tblView;

- (id)initSafetyConfirmView {
	if (self = [super init]) {
		displayId = DISPLAY_ID_14;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		[self setGroupId];
		[self setFamilyId];
		
		// 個人情報一覧取得
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

	// 送信ボタン
	UIBarButtonItem *sendButton = [[[UIBarButtonItem alloc] 
									initWithTitle:@"送信"
									style:UIBarButtonItemStylePlain
									target:self
									action:@selector(pushSendButton:)] autorelease];	
	self.navigationItem.rightBarButtonItem = sendButton;
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
#pragma mark Button actions
- (void)pushSendButton:(id)sender {
	// 送信処理
	[self postData];
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
	static NSString *CellIdentifier = @"safetyConfirmTableCell";
	
	SafetyConfirmViewCell *cell = (SafetyConfirmViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
//		cell = [[[SafetyConfirmViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[SafetyConfirmViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	cell.tag = 100 + itemIndex;
	
	PersonalsInfo *mng = (PersonalsInfo *)[items objectAtIndex:itemIndex];
	// 氏名
	[cell.cellFullName setText:[NSString stringWithFormat:@"%@",mng.fullName]];
	
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0: // 1個目のセクションの場合
			//            return [NSString stringWithFormat:@"%@家",familyName];
            return @"ご家族の安否情報を選択して、上記の送信ボタンを押してください";
            break;
        default: // 2個目のセクションの場合
            return @"";
            break;
    }
    return nil;
}


#pragma mark -
#pragma mark Data Source
- (void)requestPersonal {
	// Table
	NSError *parseError = nil;  
	
	NSString *url = [[NSString alloc]initWithFormat:@"%@%@?family_id=%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_PERSONALS"],
					 familyId];
	NSLog(@"url = %@", url);
	
	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
	
}

- (void)postData {
	static NSString* const BOUNDARY = @"scopeproject2010----------";
	
	// 8.1 安否情報登録リクエスト 
	
	NSString *url = [NSString stringWithFormat:@"%@%@",
#if TARGET_IPHONE_SIMULATOR
					 [self getProperties:@"SERVER_DEBUG"], 
#else	
					 [self getProperties:@"SERVER"], 
#endif
					 [self getProperties:@"API_KEY_PERSONAL_SAFETIES_POST"]];

	NSLog(@"url  = %@", url);
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
//	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",BOUNDARY];
	NSString *contentType = [NSString stringWithFormat:@"application/xml; boundary=%@",BOUNDARY];	
	
 	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];

	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_SAFETIES] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_GROUP_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:groupId] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_GROUP_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_FAMILY_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithString:familyId] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_FAMILY_ID] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_SAFETY] dataUsingEncoding:NSUTF8StringEncoding]];
	for (int i=0; i < [items count]; i++) {
		UIView *cell = (UIView*)[tblView viewWithTag:100+i];
		PersonalsInfo *peronalsInfo = [items objectAtIndex:i]; 
		[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_PERSONAL_ID] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithString:peronalsInfo.personalId] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_PERSONAL_ID] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"<%@>",ELEMENT_NAME_PERSONAL_SAFETY_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"%d", ((SafetyConfirmViewCell *)cell).segCtrl.selectedSegmentIndex + 1] dataUsingEncoding:NSUTF8StringEncoding]];
		[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_PERSONAL_SAFETY_KIND] dataUsingEncoding:NSUTF8StringEncoding]];
	}
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_SAFETY] dataUsingEncoding:NSUTF8StringEncoding]];
	[body appendData:[[NSString stringWithFormat:@"</%@>",ELEMENT_NAME_SAFETIES] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	
	// URLコネクションを作る
	[NSURLConnection connectionWithRequest:request delegate:self];
	
}

- (void)connection:(NSURLConnection*)connection
	didReceiveData:(NSData*)data {
	char* p = (char*)[data bytes];
	int len = [data length];
	while (len-- > 0) {
		putchar(*p++);
	}

	// XML解析
	NSError *parseError = nil;
	[self parseXMLFileAtData:data parseError:&parseError];
	
	// error判定
	if (![results isEqualToString:@"OK"]) {
		[self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
				message:[NSString stringWithFormat:@"%@の送信に失敗しました",[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			  okBtnName:@"OK"];
	} else {
		[self alertView:[NSString stringWithString:[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
				message:[NSString stringWithFormat:@"%@の送信に成功しました",[self getProperties:@"DISPLAY_TITLE" indexName:displayId]]
			  okBtnName:@"OK"];
	}
}

@end
