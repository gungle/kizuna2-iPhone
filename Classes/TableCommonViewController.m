//
//  TableCommonViewController.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "TableCommonViewController.h"


@implementation TableCommonViewController

@synthesize tblView;

- (id)init {
    if (self = [super init]) {
		tblStyle = UITableViewStyleGrouped;
	}
    return self;
}

- (id)initWithTableViewStylePlain {
    if (self = [super init]) {
		tblStyle = UITableViewStylePlain;
	}
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
//	tblView = [[UITableView alloc] initWithFrame:[self.view bounds] style:tblStyle];
	tblView = [[UITableView alloc] initWithFrame:CGRectMake(DEFAULT_TABLE_X,
															DEFAULT_TABLE_Y,
															DEFAULT_TABLE_WIDTH,
															DEFAULT_TABLE_HEIGHT)
										   style:tblStyle];
	tblView.delegate = self;
	tblView.dataSource = self;
	[tblView setAllowsSelection:YES];
	[self.view addSubview:tblView];
}

//Viewが表示される直前に実行される
- (void)viewWillAppear:(BOOL)animated {
	NSIndexPath* selection = [tblView indexPathForSelectedRow];
	if(selection){
		[tblView deselectRowAtIndexPath:selection animated:YES];
	}
	[tblView reloadData];
}

//Viewが表示された直後に実行される
- (void)viewDidAppear:(BOOL)animated {
	[self.tblView flashScrollIndicators];
}


- (void)dealloc {
//	[items release];
	[tblView   release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}
@end
