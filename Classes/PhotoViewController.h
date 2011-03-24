//
//  PhotoViewController.h
//  Scope2
//	(15)災害情報詳細画面（画像表示）
//
//  Created by YOSHIDA Hiroyuki on 10/09/16.
//  Copyright 2010 Institute for HyperNetwork Society. All rights reserved.
//

#import "CommonViewController.h"

@interface PhotoViewController : CommonViewController {

	NSString *imagePath;
}

@property (nonatomic, retain) NSString *imagePath;

- (id)initWithImagePath:(NSString *)path;

@end
