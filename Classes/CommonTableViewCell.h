//
//  CommonTableViewCell.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//


@interface CommonTableViewCell : UITableViewCell {
	UILabel      *cellTitle;
	UILabel      *cellSubTitle;
	UILabel      *cellLabel1;
	UILabel      *cellLabel2;
	UILabel      *cellLabel3;
	UILabel      *cellDate;
	UIImageView  *cellIcon;
	UIImageView  *cellManIcon;
	UIImageView  *cellWomanIcon;
	UIView       *bgView;
	
}

@property (nonatomic, retain) UILabel *cellTitle;
@property (nonatomic, retain) UILabel *cellSubTitle;
@property (nonatomic, retain) UILabel *cellLabel1;
@property (nonatomic, retain) UILabel *cellLabel2;
@property (nonatomic, retain) UILabel *cellLabel3;
@property (nonatomic, retain) UILabel *cellDate;
@property (nonatomic, retain) UIImageView *cellIcon;
@property (nonatomic, retain) UIImageView *cellManIcon;
@property (nonatomic, retain) UIImageView *cellWomanIcon;
@property (nonatomic, retain) UIView *bgView;

@end
