//
//  DisasterListViewController.h
//  Scope2
//	(11)災害時トップ画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "TableCommonViewController.h"
#import "DisasterData.h"
#import "DisastersInfo.h"

@interface DisasterListViewController : TableCommonViewController {
	DisasterData      *disasterData;
	DisastersInfo     *disastersInfo;

	NSString *xmlGroupId;
	NSString *xmlGroupName;
	UILabel *triggerHeader;
	UIImageView *imageView;
	BOOL    headerOn;
}

@property (nonatomic, retain)NSString *xmlGroupId;
@property (nonatomic, retain)NSString *xmlGroupName;
@property (nonatomic, retain)UILabel *triggerHeader;
@property (nonatomic, retain)UIImageView *imageView;


- (void)requestDisaster;
- (void)pushSafetyInputButton:(id)sender;
- (void)pushVictimInputButton:(id)sender;

@end

@interface DisasterListViewController(Xml)

@end
