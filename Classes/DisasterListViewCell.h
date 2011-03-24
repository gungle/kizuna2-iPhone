//
//  DisasterListViewCell.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/13.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//


@interface DisasterListViewCell : UITableViewCell {
	UILabel      *cellFullName;
	UILabel      *cellSex;
	UILabel      *cellAge;
	UILabel      *cellExplain;
	UIImageView  *cellCheckImage;
	UIImageView  *cellNonCheckImage;
	UIImageView  *cellManIcon;
	UIImageView  *cellWomanIcon;

	UIView       *bgView;
	
	UILabel      *cellMemo;
}

@property (nonatomic, retain) UILabel *cellFullName;
@property (nonatomic, retain) UILabel *cellSex;
@property (nonatomic, retain) UILabel *cellAge;
@property (nonatomic, retain) UILabel *cellExplain;
@property (nonatomic, retain) UIImageView *cellCheckImage;
@property (nonatomic, retain) UIImageView *cellNonCheckImage;
@property (nonatomic, retain) UIImageView *cellManIcon;
@property (nonatomic, retain) UIImageView *cellWomanIcon;
@property (nonatomic, retain) UIView *bgView;

@property (nonatomic, retain) UILabel *cellMemo;
@end
