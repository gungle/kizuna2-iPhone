//
//  MyImageView.m
//  MyZooomr
//
//  Created by hir_y on 10/01/12.
//  Copyright hir_y 2010. All rights reserved.
//----------------------------------------------

#import "CommonImageView.h"


@implementation CommonImageView

@synthesize imagePath;
@synthesize indexId;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		//タッチの可否
		self.userInteractionEnabled = TRUE;
		//マルチタッチの可否
		self.multipleTouchEnabled = TRUE;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[imagePath release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	NSLog(@"tuchesBegan Image view");
	[[self nextResponder] touchesBegan:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	NSLog(@"tuchesEnd Image view");
	[[self nextResponder] touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	NSLog(@"touchesMoved Image view");
	[[self nextResponder] touchesMoved:touches withEvent:event];
}

@end
