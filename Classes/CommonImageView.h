//
//  MyImageView.h
//  MyZooomr
//
//  Created by hir_y on 10/01/12.
//  Copyright hir_y 2010. All rights reserved.
//----------------------------------------------

@interface CommonImageView : UIImageView {
	int indexId;
	NSString *imagePath;
}

@property (nonatomic, retain) NSString *imagePath;
@property (nonatomic) int indexId;

@end