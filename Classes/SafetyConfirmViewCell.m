//
//  SafetyConfirmViewCell.m
//  Scope2
//	(14)安否確認画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright 2010 Institute for HyperNetwork Society. All rights reserved.
//

#import "SafetyConfirmViewCell.h"
#import "Scope2Properties.h"
#import "PropertiesUtil.h"


@implementation SafetyConfirmViewCell

@synthesize cellFullName;
@synthesize segCtrl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
 		
		cellFullName = [[UILabel alloc] initWithFrame:CGRectMake(SAFETY_CONFIRM_FULL_NAME_X,
																 SAFETY_CONFIRM_FULL_NAME_Y,
																 SAFETY_CONFIRM_FULL_NAME_WIDTH,
																 SAFETY_CONFIRM_FULL_NAME_HEIGHT)]; 
		cellFullName.font = [UIFont boldSystemFontOfSize:SAFETY_CONFIRM_FONT_SIZE];
		[self.contentView addSubview:cellFullName];
		
		segCtrl = [[UISegmentedControl alloc] initWithItems:nil];
		segCtrl.segmentedControlStyle = UISegmentedControlStyleBar;
		[segCtrl setFrame:CGRectMake(SAFETY_CONFIRM_STATUS_SEGMENTED_X,
									 SAFETY_CONFIRM_STATUS_SEGMENTED_Y,
									 SAFETY_CONFIRM_STATUS_SEGMENTED_WIDTH,
									 SAFETY_CONFIRM_STATUS_SEGMENTED_HEIGHT)];
		segCtrl.momentary = NO;
		[segCtrl insertSegmentWithTitle:[PropertiesUtil getProperties:@"DIC_PERSONAL_SAFETY_KIND" indexName:1] atIndex:0 animated:YES];
		[segCtrl insertSegmentWithTitle:[PropertiesUtil getProperties:@"DIC_PERSONAL_SAFETY_KIND" indexName:2] atIndex:1 animated:YES];
		segCtrl.selectedSegmentIndex = 0;
		[self.contentView addSubview:segCtrl];
	}
//	cellFullName.backgroundColor = [UIColor cyanColor];
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[cellFullName release];
	[segCtrl      release];
    [super        dealloc];
}

@end
