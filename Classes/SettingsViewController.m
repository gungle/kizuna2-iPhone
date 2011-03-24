//
//  SettingsViewController.m
//  Scope2
//  (31)設定画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsViewCell.h"


@implementation SettingsViewController

- (id)init {
	if (self = [super init]) {
		displayId = DISPLAY_ID_31;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		items = [[NSMutableArray alloc]initWithCapacity:2];
		[items addObject:@"ログインID"];
		[items addObject:@"パスワード"];
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *loginButton = [[[UIBarButtonItem alloc] 
									initWithTitle:@"ログイン"
									style:UIBarButtonItemStylePlain
									target:self
									action:@selector(pushLoginButton:)] autorelease];	
	self.navigationItem.rightBarButtonItem = loginButton;
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

- (void)pushLoginButton:(id)sender {	
	// ログインID、パスワード取得
	NSString *loginId;
	NSString *password;
	NSArray *array = [tblView visibleCells];
	
	for (SettingsViewCell *cell in array) {
		if (cell != nil) {
//			NSLog(@"cell tag = %d",cell.tag);
			if (cell.tag == 200) {
				loginId = cell.cellInput.text;
//				NSLog(@"loginId = %@",cell.cellInput.text);
			} else if (cell.tag == 201) {
				password = cell.cellInput.text;
//				NSLog(@"password = %@",cell.cellInput.text);
			}
		}
		
	}
	
	Scope2AppDelegate *scope2Delegate = (Scope2AppDelegate *)[[UIApplication sharedApplication] delegate];
	[scope2Delegate login:loginId password:password];
	[scope2Delegate.tabBarController setSelectedIndex:0];
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
	static NSString *CellIdentifier = @"settingsTableCell";
	
	SettingsViewCell *cell = (SettingsViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[SettingsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.cellDelegate = self;
	
	int itemIndex = [indexPath indexAtPosition:[indexPath length] -1];
	cell.tag = 200 + itemIndex;
	
	if (itemIndex == 0) {
		// ログインID
		[cell.cellInput setText:[self getApplicationProperties:@"login_id"]];
		
	} else {
		// パスワード
		[cell.cellInput setText:[self getApplicationProperties:@"password"]];
		cell.cellInput.secureTextEntry = YES;
	}

	[cell.cellTitle setText:[NSString stringWithFormat:@"%@",[items objectAtIndex:itemIndex]]];
	[cell.cellInput.delegate self];
	
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"ユーザ情報設定";
            break;
        default: // 2個目のセクションの場合
            return @"";
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tblView deselectRowAtIndexPath:[tblView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark SettingsViewCellDelegate
- (void)cellEdittingDidFinishInitialize:(SettingsViewCell *)cell{
//	NSLog(@"cellEdittingDidFinishInitialize >");
	if (cell.tag == 200) {
		[self setApplicationProperties:cell.cellInput.text key:@"login_id"];
	} else {
		[self setApplicationProperties:cell.cellInput.text key:@"password"];
	}
}


@end
