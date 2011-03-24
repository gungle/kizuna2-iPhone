//
//  GroupListViewController.h
//  Scope2
//	(1)平常時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "TableCommonViewController.h"

@interface GroupListViewController : TableCommonViewController{
}


- (void)requestClass;

@end

@class GroupsInfo;
@interface GroupListViewController(Xml)
	GroupsInfo *groupsInfo;

@end
