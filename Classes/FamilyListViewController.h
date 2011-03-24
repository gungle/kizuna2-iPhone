//
//  FamilyListViewController.h
//  Scope2
//	(2)世帯一覧画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "TableCommonViewController.h"

@class GroupsInfo;

@interface FamilyListViewController : TableCommonViewController {
}

- (id)initFamilyListView:(GroupsInfo *)selectedClassMng;
- (void)requestFamily;

@end


@class FamiliesInfo;
@interface FamilyListViewController(Xml)
	FamiliesInfo *familiesInfo;

@end
