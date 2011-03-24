//
//  SettingsViewCell.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "SettingsViewCell.h"
#import "Scope2Properties.h"


@implementation SettingsViewCell

@synthesize cellTitle;
@synthesize cellInput;
@synthesize cellDelegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 35)]; 
		cellTitle.font = [UIFont boldSystemFontOfSize:SETTINGS_FONT_SIZE];
		cellTitle.backgroundColor = [UIColor clearColor];
		[self addSubview:cellTitle];

		cellInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, 180, 35)]; 
		cellInput.font = [UIFont systemFontOfSize:SETTINGS_FONT_SIZE];
		cellInput.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		cellInput.backgroundColor = [UIColor clearColor];
		cellInput.clearButtonMode = UITextFieldViewModeWhileEditing;
		[self addSubview:cellInput];
		cellInput.delegate = self;
    }
	
//	cellTitle.backgroundColor = [UIColor cyanColor];
//	cellInput.backgroundColor = [UIColor magentaColor];
    return self;
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
*/

- (void)dealloc {
	[cellInput setDelegate:nil];
	[cellTitle    release];
	[cellInput    release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
//	NSLog(@"textFieldDidBeginEditing >");
    self.cellInput = textField;
//	NSLog(@" > OK");
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//	NSLog(@"textFieldDidEndEditing > ");
	[self.cellDelegate cellEdittingDidFinishInitialize:self];
//    self.cellInput = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//	NSLog(@"textFieldShouldReturn > ");
    [self.cellInput resignFirstResponder];
//	NSLog(@" > OK");
    return YES;
}

@end
