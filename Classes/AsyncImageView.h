//
//  AsyncImageView.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 09/11/26.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AsyncImageView : UIImageView {
@private
	NSURLConnection *connection;
	NSMutableData   *imageData;
	NSIndexPath     *indexPath;
}

@property (retain) NSMutableData *imageData;
@property (retain) NSIndexPath *indexPath;

-(void)loadImage:(NSString *)url mode:(int)mode;
-(void)loadImage:(NSString *)url;
- (void)notifyImageLoadFinish;
-(void)abort;

@end
