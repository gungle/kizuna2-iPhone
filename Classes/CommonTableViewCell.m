//
//  CommonTableViewCell.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "Scope2Properties.h"

@implementation CommonTableViewCell

@synthesize cellTitle;
@synthesize cellSubTitle;
@synthesize cellLabel1;
@synthesize cellLabel2;
@synthesize cellLabel3;
@synthesize cellDate;
@synthesize cellIcon;
@synthesize cellManIcon;
@synthesize cellWomanIcon;
@synthesize bgView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		self.cellTitle    = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellSubTitle = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellLabel1   = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellLabel2   = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellLabel3   = [[UILabel alloc] initWithFrame:CGRectZero]; 
		self.cellIcon     = [[UIImageView alloc] init];
		[self.cellIcon setImage:[UIImage imageNamed:ICON_NAME_DISASTER_WEAK]];

		self.cellManIcon   = [[UIImageView alloc] init];
		[self.cellManIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_MAN]];
		self.cellWomanIcon = [[UIImageView alloc] init];
		[self.cellWomanIcon setImage:[UIImage imageNamed:ICON_NAME_SEX_WOMAN]];
		

//		cellTitle.backgroundColor = [UIColor cyanColor];
//		cellSubTitle.backgroundColor = [UIColor magentaColor];
//		cellLabel1.backgroundColor = [UIColor yellowColor];
//		cellLabel2.backgroundColor = [UIColor greenColor];
//		cellLabel3.backgroundColor = [UIColor cyanColor];
//		cellManIcon.backgroundColor = [UIColor cyanColor];
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[cellTitle     release];
	[cellSubTitle  release];
	[cellLabel1    release];
	[cellLabel2    release];
	[cellLabel3    release];
	[cellDate      release];
	[cellIcon      release];
	[cellManIcon   release];
	[cellWomanIcon release];
	[bgView        release];
    [super dealloc];
}


@end
