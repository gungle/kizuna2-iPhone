//
//  TableCommonViewController.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "CommonViewController.h"


@interface TableCommonViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource>{
	UITableView    *tblView;
	UITableViewStyle tblStyle;
}

@property (nonatomic, retain) UITableView *tblView;

- (id)initWithTableViewStylePlain;

@end
