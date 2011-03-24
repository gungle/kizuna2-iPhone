//
//  SettingsViewCell.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SettingsViewCell;
@protocol SettingsViewCellDelegate<NSObject>
@optional
- (void)cellEdittingDidFinishInitialize:(SettingsViewCell *)cell;
@end

@interface SettingsViewCell : UITableViewCell <UITextFieldDelegate>{
	UILabel      *cellTitle;
	UITextField  *cellInput;
	id<SettingsViewCellDelegate> cellDelegate;
}

@property (nonatomic, retain) UILabel      *cellTitle;
@property (nonatomic, retain) UITextField  *cellInput;
@property (nonatomic, assign) id<SettingsViewCellDelegate> cellDelegate;

@end
