//
//  AsyncImageView.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 09/11/26.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "AsyncImageView.h"


@implementation AsyncImageView

@synthesize indexPath;
@synthesize imageData;


-(void)loadImage:(NSString *)url mode:(int)mode {

	if (mode == 0) {
		self.contentMode = UIViewContentModeScaleAspectFit;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth || UIViewAutoresizingFlexibleHeight;				
	} else if (mode == 1) {
		self.contentMode = UIViewContentModeScaleToFill;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	} else {
		self.contentMode = UIViewContentModeScaleToFill;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	} 
	
	[self abort];
	
	imageData = [[NSMutableData alloc] initWithCapacity:0];
	
	NSURLRequest *request = [NSURLRequest 
							 requestWithURL:[NSURL URLWithString:url] 
							 cachePolicy:NSURLRequestUseProtocolCachePolicy
							 timeoutInterval:30.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)loadImage:(NSString *)url {
	[self loadImage:url mode:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[imageData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata {
	[imageData appendData:nsdata];	
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[self abort];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

	self.image = [UIImage imageWithData:imageData];
	/*	
	//マスク画像
	UIImage *maskImage = [UIImage imageNamed:@"round_black.png"];
	
	//マスク画像をCGImageに変換する
	CGImageRef maskRef = maskImage.CGImage; 
	//マスクを作成する
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	
	//マスクの形に切り抜く
	CGImageRef masked = CGImageCreateWithMask([[UIImage imageWithData:imageData] CGImage], mask);
	//CGImageをUIImageに変換する
	UIImage *maskedImage = [UIImage imageWithCGImage:masked];
	
	CGImageRelease(mask);
	CGImageRelease(masked);
	
	self.image = maskedImage;
*/	
	
	[self notifyImageLoadFinish];
	
	[self abort];
}

- (void)notifyImageLoadFinish {
	[[NSNotificationCenter defaultCenter]
     postNotificationName: @"nothiFyImageLoadFinish"
     object: self];	
}

-(void)abort{
	if(connection != nil){
		[connection cancel];
		[connection release];
		connection = nil;
	}
/*
	if(imageData != nil){
		[imageData release];
		imageData = nil;
	}
*/
}

- (void)dealloc {
	[connection cancel];
    [connection release];
    [imageData release];
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
