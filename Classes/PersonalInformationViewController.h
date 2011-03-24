//
//  PersonalsInformationViewController.h
//  Scope2
//	(4)個人情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/06.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalXMLParserViewController.h"

@class PersonalsInfo;

@interface PersonalInformationViewController : PersonalXMLParserViewController <UITableViewDelegate, UITableViewDataSource>{
	PersonalsInfo      *personalInfo;			// 個人情報管理データ
}



- (id)initPersonalInfoView:(PersonalsInfo *)selectedPersonalMng;
- (void)requestPersonalInformation;

@end
