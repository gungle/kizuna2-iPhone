//
//  DisasterPickerView.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/15.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DisasterPickerView;
@protocol DisasterPickerViewDelegate<NSObject>
@optional
- (void)selectedDidFinishInitialize:(DisasterPickerView *)pickerView;
@end

@interface DisasterPickerView : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource> {
//	id pickerViewDelegate;
	id<DisasterPickerViewDelegate> pickerViewDelegate;
	
	NSMutableArray *personalArray;
	NSMutableArray *emergencyArray;
	NSMutableArray *statusArray;

	NSInteger personalValue;
	NSInteger emergencyKindValue;
	NSInteger disasterStatusKindValue;
}

//@property (nonatomic, assign) id pickerViewDelegate;
@property (nonatomic, assign) id<DisasterPickerViewDelegate> pickerViewDelegate;
@property (nonatomic, retain) NSMutableArray *personalArray;
@property (nonatomic, retain) NSMutableArray *emergencyArray;
@property (nonatomic, retain) NSMutableArray *statusArray;

@property (nonatomic) NSInteger personalValue;
@property (nonatomic) NSInteger emergencyKindValue;
@property (nonatomic) NSInteger disasterStatusKindValue;

- (id)initWithFramePersonals:(CGRect)aRect items:(NSMutableArray *)items;
@end

