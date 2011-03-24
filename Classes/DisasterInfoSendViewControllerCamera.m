//
//  DisasterInfoSendViewControllerCamera.m
//  Scope2
//	(13)災害情報送信画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/15.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "DisasterInfoSendViewController.h"


@implementation DisasterInfoSendViewController(Camera)


#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (actionMode == 0) {
		// ボタンインデックスをチェックする
		if (buttonIndex >= 3) {
			return;
		}
		
		// ソースタイプを決定する
		UIImagePickerControllerSourceType sourceType = 0;
		switch (buttonIndex) {
			case 0: {
				sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				break;
			}
			case 1: {
				sourceType = UIImagePickerControllerSourceTypeCamera;
				break;
			}
			default: {
				sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
				break;
			}
		}
		
		// 使用可能かどうかチェックする
		if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {  
			return;
		}
		
		UIImagePickerController* picker = [[UIImagePickerController alloc] init];
		picker.sourceType = sourceType;
		//    picker.allowsImageEditing = YES;
		picker.delegate = self;
		
		[self presentModalViewController:picker animated:YES];	
	} else {
		// ボタンインデックスをチェックする
		if (buttonIndex >= 2) {
			return;
		}
		if (buttonIndex == 0) {
			// upload
//			[self pushDownUpload];
		} else {
			// cancel
//			[self pushDownCancel];
		}
		
	}
	
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	CGImageRef imageRef = [[info objectForKey:UIImagePickerControllerOriginalImage] CGImage];
	orgImage = [[UIImage alloc]initWithCGImage:imageRef];
	
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
	photoFlag = YES;
	[photoViewOff setHidden:YES];
	[photoViewOn setHidden:NO];
	[clipImage setHidden:NO];
}

/* iPhone 3.0未満？！
/// 画像が選択されたときに呼ばれるデリゲート関数
- (void) imagePickerController:(UIImagePickerController*)picker
         didFinishPickingImage:(UIImage*)image
                   editingInfo:(NSDictionary*)editingInfo
{
	NSLog(@"○○○○○○○");
	CGImageRef imageRef = [image CGImage];
	
	// upload用のイメージを保持
	orgImage = [[UIImage alloc]initWithCGImage:imageRef];
	
//	UIGraphicsBeginImageContext(CGSizeMake(320, 460));  
//	[image drawInRect:CGRectMake(0, 0, 320, 460)];
	
//	image = UIGraphicsGetImageFromCurrentImageContext();  
//	UIGraphicsEndImageContext();  
	
//	imageView.image= (UIImage *)image;
	//	imageView.image= [self scaleAndRotateImage:image];

    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
	
	photoFlag = YES;
	[photoViewOff setHidden:YES];
	[photoViewOn setHidden:NO];
	[clipImage setHidden:NO];
}
*/

/// 画像の選択がキャンセルされたときに呼ばれるデリゲート関数
- (void) imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void)presentModalImageViewPicker {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
	//    picker.allowsImageEditing = YES;
	
    [self presentModalViewController:picker animated:YES];
}

@end
