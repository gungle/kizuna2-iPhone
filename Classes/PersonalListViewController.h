//
//  PersonalListViewController.h
//  Scope2
//	(3)家族一覧画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/02.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PersonalXMLParserViewController.h"

@class FamiliesInfo;

@interface PersonalListViewController : PersonalXMLParserViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView    *tblView;
	UITableViewStyle tblStyle;
}

@property (nonatomic, retain) UITableView *tblView;

- (id)initPersonalListView:(FamiliesInfo *)selectedFamilMng;
- (void)requestPersonal;
@end
