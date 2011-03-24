//
//  PhotoViewController.m
//  Scope2
//	(15)災害情報詳細画面（画像表示）
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright 2010 Institute for HyperNetwork Society. All rights reserved.
//

#import "PhotoViewController.h"
#import "AsyncImageView.h"

@implementation PhotoViewController

@synthesize imagePath;

- (id)initWithImagePath:(NSString *)path {
    if (self = [super init]) {
        // Custom initialization
		displayId = DISPLAY_ID_15;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		imagePath = [NSString stringWithString:path];
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[self.view setBackgroundColor:[UIColor blackColor]];
	AsyncImageView *ai = [[AsyncImageView alloc] initWithFrame:CGRectMake(PHOTO_VIEW_X, 
																		  PHOTO_VIEW_Y,
																		  PHOTO_VIEW_WIDTH,
																		  PHOTO_VIEW_HIEGHT)];
	// サムネイル画像
	[ai loadImage:imagePath];
	[self.view addSubview:ai];
	[ai release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[imagePath release];
    [super dealloc];
}


@end
