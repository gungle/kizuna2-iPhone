//
//  DisasterListViewCell.m
//  Scope2
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterListViewCell.h"
#import "Scope2Properties.h"

@implementation DisasterListViewCell

@synthesize cellFullName;
@synthesize cellSex;
@synthesize cellAge;
@synthesize cellExplain;
@synthesize cellCheckImage;
@synthesize cellNonCheckImage;
@synthesize cellManIcon;
@synthesize cellWomanIcon;
@synthesize bgView;
@synthesize cellMemo;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		self.cellFullName      = [[UILabel alloc] initWithFrame:CGRectZero]; 
//		self.cellSex           = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellAge           = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellExplain       = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellCheckImage    = [[UIImageView alloc] init];
		[self.cellCheckImage setImage:[UIImage imageNamed:ICON_NAME_CHECK]];
		self.cellNonCheckImage = [[UIImageView alloc] init];
		[self.cellNonCheckImage setImage:[UIImage imageNamed:ICON_NAME_NON_CHECK]];
		self.cellManIcon   = [[UIImageView alloc] init];
		[self.cellManIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_MAN]];
		self.cellWomanIcon = [[UIImageView alloc] init];
		[self.cellWomanIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_WOMAN]];
		self.cellMemo       = [[UILabel alloc] initWithFrame:CGRectZero]; 

		// 氏名
		self.cellFullName.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_FULL_NAME_X, 
											 DISASTER_LIST_TABLE_CELL_FULL_NAME_Y, 
											 DISASTER_LIST_TABLE_CELL_FULL_NAME_WIDTH, 
											 DISASTER_LIST_TABLE_CELL_FULL_NAME_HEIGHT);
		self.cellFullName.font = [UIFont boldSystemFontOfSize:DISASTER_LIST_TABLE_CELL_FONT_SIZE];
		[self.contentView addSubview:self.cellFullName];
		
		// 災害状況
		self.cellExplain.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_EXPLAIN_X, 
											DISASTER_LIST_TABLE_CELL_EXPLAIN_Y, 
											DISASTER_LIST_TABLE_CELL_EXPLAIN_WIDTH, 
											DISASTER_LIST_TABLE_CELL_EXPLAIN_HEIGHT);
		self.cellExplain.font = [UIFont systemFontOfSize:DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE];
		[self.contentView addSubview:self.cellExplain];
		
		// 性別
//		self.cellSex.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_SEX_X, 
//										DISASTER_LIST_TABLE_CELL_SEX_Y, 
//										DISASTER_LIST_TABLE_CELL_SEX_WIDTH, 
//										DISASTER_LIST_TABLE_CELL_SEX_HEIGHT);
//		self.cellSex.font = [UIFont systemFontOfSize:DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE];
//		[self.contentView addSubview:self.cellSex];
		
		// 年齢
		self.cellAge.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_AGE_X, 
										   DISASTER_LIST_TABLE_CELL_AGE_Y, 
										   DISASTER_LIST_TABLE_CELL_AGE_WIDTH, 
										   DISASTER_LIST_TABLE_CELL_AGE_HEIGHT);
		self.cellAge.font = [UIFont systemFontOfSize:DISASTER_LIST_TABLE_CELL_FONT_SIZE];
		[self.contentView addSubview:self.cellAge];
		
		self.cellCheckImage.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_ICON_X, 
										 DISASTER_LIST_TABLE_CELL_ICON_Y, 
										 DISASTER_LIST_TABLE_CELL_ICON_WIDTH, 
										 DISASTER_LIST_TABLE_CELL_ICON_HEIGHT);
		[self.contentView addSubview:self.cellCheckImage];

		self.cellNonCheckImage.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_ICON_X, 
											   DISASTER_LIST_TABLE_CELL_ICON_Y, 
											   DISASTER_LIST_TABLE_CELL_ICON_WIDTH, 
											   DISASTER_LIST_TABLE_CELL_ICON_HEIGHT);
		[self.contentView addSubview:self.cellNonCheckImage];

		self.cellManIcon.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_SEX_ICON_X, 
											DISASTER_LIST_TABLE_CELL_SEX_ICON_Y, 
											DISASTER_LIST_TABLE_CELL_SEX_ICON_WIDTH, 
											DISASTER_LIST_TABLE_CELL_SEX_ICON_HEIGHT);
		[self.contentView addSubview:self.cellManIcon];
		[self.cellManIcon setHidden:YES];
		self.cellWomanIcon.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_SEX_ICON_X, 
											  DISASTER_LIST_TABLE_CELL_SEX_ICON_Y, 
											  DISASTER_LIST_TABLE_CELL_SEX_ICON_WIDTH, 
											  DISASTER_LIST_TABLE_CELL_SEX_ICON_HEIGHT);
		[self.contentView addSubview:self.cellWomanIcon];
		[self.cellWomanIcon setHidden:YES];
		
		self.bgView = [[UIView alloc]initWithFrame:self.frame];
		self.backgroundView = self.bgView;

		// 災害メモ
		self.cellMemo.frame = CGRectMake(DISASTER_LIST_TABLE_CELL_MEMO_X, 
										DISASTER_LIST_TABLE_CELL_MEMO_Y, 
										DISASTER_LIST_TABLE_CELL_MEMO_WIDTH, 
										DISASTER_LIST_TABLE_CELL_MEMO_HEIGHT);
		self.cellMemo.font = [UIFont systemFontOfSize:DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE];
		[self.contentView addSubview:self.cellMemo];

//		cellFullName.backgroundColor = [UIColor cyanColor];
//		cellAge.backgroundColor = [UIColor magentaColor];
//		cellExplain.backgroundColor = [UIColor yellowColor];
//		cellMemo.backgroundColor = [UIColor greenColor];

		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
}


- (void)dealloc {
	[cellFullName      release];
	[cellSex           release];
	[cellAge           release];
	[cellExplain       release];
	[cellCheckImage    release];
	[cellNonCheckImage release];
	[cellManIcon       release];
	[cellWomanIcon     release];
	[bgView            release];
	[cellMemo          release];
    [super dealloc];
}


@end
