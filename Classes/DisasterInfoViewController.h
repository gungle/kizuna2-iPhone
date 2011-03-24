//
//  DisasterInfoViewController.h
//  Scope2
//	(12)災害情報画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/13.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "CommonViewController.h"

@class DisastersInfo;

@interface DisasterInfoViewController : CommonViewController {
	DisastersInfo *disastersInfo;
	int triageTag;
	int doneKindTag;
}

@property (nonatomic, retain) DisastersInfo *disastersInfo;

- (id)initDisasterInfoView:(DisastersInfo *)selectedDisasterMng;
- (void)requestDisasterInfo;
- (void)pushUpdateButton:(id)sender;

- (void)putData:(NSInteger)triage doneKind:(NSInteger)doneKind;

@end

@interface DisasterInfoViewController(Xml)

@end