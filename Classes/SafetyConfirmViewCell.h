//
//  SafetyConfirmViewCell.h
//  Scope2
//	(14)安否確認画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright 2010 Institute for HyperNetwork Society. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SafetyConfirmViewCell : UITableViewCell {
	UILabel      *cellFullName;
	UISegmentedControl *segCtrl;
}

@property (nonatomic, retain) UILabel *cellFullName;
@property (nonatomic, retain) UISegmentedControl *segCtrl;
@end
