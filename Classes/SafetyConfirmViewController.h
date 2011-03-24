//
//  SafetyConfirmViewController.h
//  Scope2
//	(14)安否確認画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalXMLParserViewController.h"


@interface SafetyConfirmViewController : PersonalXMLParserViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView    *tblView;
	UITableViewStyle tblStyle;
}

@property (nonatomic, retain) UITableView *tblView;

- (id)initSafetyConfirmView;
- (void)requestPersonal;
- (void)postData;

@end
