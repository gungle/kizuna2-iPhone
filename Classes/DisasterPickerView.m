//
//  DisasterPickerView.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/15.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterPickerView.h"
#import "PersonalsInfo.h"
#import "PropertiesUtil.h"
#import "Scope2Properties.h"


@implementation DisasterPickerView

@synthesize pickerViewDelegate;
@synthesize personalArray;
@synthesize emergencyArray;
@synthesize statusArray;

@synthesize personalValue;
@synthesize emergencyKindValue;
@synthesize disasterStatusKindValue;
//@synthesize delegate;


- (id)initWithFramePersonals:(CGRect)aRect items:(NSMutableArray *)items {
    if ([super initWithFrame:aRect] != nil)
    {
        self.delegate = self;
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
		
		self.clipsToBounds = YES;
		personalArray = [[NSMutableArray alloc]initWithCapacity:0];
		for (PersonalsInfo *info in items) {
			[personalArray addObject:info.fullName];
		}
		
		emergencyArray = [[NSArray alloc]initWithArray:[PropertiesUtil getPropertiesArray:@"DIC_EMERGENCY_KIND"]];
		statusArray = [[NSArray alloc]initWithArray:[PropertiesUtil getPropertiesArray:@"DIC_DISASTER_STATUS_KIND"]];
		
		personalValue = 0;
		emergencyKindValue = 0;
		disasterStatusKindValue = 0;
		
    }
    return self;
}

-(void)pickerViewLoaded: (id)blah {  
} 

- (void)dealloc {
	[personalArray removeAllObjects];
	[personalArray release];
	[emergencyArray release];
	[statusArray    release];	
    [super dealloc];
}

#pragma mark -
#pragma mark UIPickerViewDataSourceDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if(component == 0){
		return [personalArray count];
	} else if (component == 1) {
		return [emergencyArray count];
	}
	return [statusArray count];
	
}

#pragma mark -
#pragma mark UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if(component == 0){
		return [personalArray objectAtIndex:row];
	} else if (component == 1) {
		return [emergencyArray objectAtIndex:row];
	}
	return [statusArray objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)picker
			viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *label;
	if (view == nil) {
		view = [[UIView alloc] initWithFrame:CGRectZero];
		label = [[UILabel alloc] initWithFrame:CGRectMake(DISASTER_PICKERVIEW_LABEL_X,
														  DISASTER_PICKERVIEW_LABEL_Y,
														  DISASTER_PICKERVIEW_LABEL_WIDTH,
														  DISASTER_PICKERVIEW_LABEL_HEIGHT)];
		label.font = [UIFont boldSystemFontOfSize:DISASTER_PICKERVIEW_FONT_SIZE];
//		label.backgroundColor = [UIColor redColor];
		label.backgroundColor = [UIColor clearColor];
		label.opaque = NO;
		label.alpha = 1.0f;
		label.textAlignment = UITextAlignmentLeft;
		label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
		[label setTag:component+300];
		[view addSubview:label];
		[label release];
	} else {
		label = (UILabel *)[view viewWithTag:component+300];
	}
	
	// 表示するテキストを埋め込み
	if(component == 0){
		label.bounds = CGRectMake(DISASTER_PICKERVIEW_LABEL_COMP_0_X,
								  DISASTER_PICKERVIEW_LABEL_COMP_0_Y,
								  DISASTER_PICKERVIEW_LABEL_COMP_0_WIDTH,
								  DISASTER_PICKERVIEW_LABEL_COMP_0_HEIGHT);
		label.text = [NSString stringWithString:[personalArray objectAtIndex:row]];
	} else if (component == 1) {
		label.bounds = CGRectMake(DISASTER_PICKERVIEW_LABEL_COMP_1_X,
								  DISASTER_PICKERVIEW_LABEL_COMP_1_Y,
								  DISASTER_PICKERVIEW_LABEL_COMP_1_WIDTH,
								  DISASTER_PICKERVIEW_LABEL_COMP_1_HEIGHT);
		label.text = [NSString stringWithString:[emergencyArray objectAtIndex:row]];
	} else {
		label.bounds = CGRectMake(DISASTER_PICKERVIEW_LABEL_COMP_2_X,
								  DISASTER_PICKERVIEW_LABEL_COMP_2_Y,
								  DISASTER_PICKERVIEW_LABEL_COMP_2_WIDTH,
								  DISASTER_PICKERVIEW_LABEL_COMP_2_HEIGHT);
		label.text = [NSString stringWithString:[statusArray objectAtIndex:row]];
	}
	return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	personalValue = [pickerView selectedRowInComponent:0];
	emergencyKindValue = [pickerView selectedRowInComponent:1];
	disasterStatusKindValue = [pickerView selectedRowInComponent:2];
	[self.pickerViewDelegate selectedDidFinishInitialize:self];

}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	if(component == 0){
		return DISASTER_PICKERVIEW_COMP_0_WIDTH;
	} else if (component == 1) {
		return DISASTER_PICKERVIEW_COMP_1_WIDTH;
	} else {
		return DISASTER_PICKERVIEW_COMP_2_WIDTH;
	}
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return DISASTER_PICKERVIEW_COMP_HEIGHT;
}


@end
