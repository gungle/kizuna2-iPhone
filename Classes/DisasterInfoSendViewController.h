//
//  DisasterInfoSendViewController.h
//  Scope2
//	(13)災害情報送信画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/15.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PersonalXMLParserViewController.h"
#import "DisasterPickerView.h"

@class DisastersInfo;
@class CommonScrollView;

@interface DisasterInfoSendViewController : PersonalXMLParserViewController <CLLocationManagerDelegate, DisasterPickerViewDelegate, UITextFieldDelegate> {
	DisasterPickerView *pickerView;
	
	UIButton *photoViewOff;
	UIButton *photoViewOn;
	UIButton *locationViewOff;
	UIButton *kicatuibVuewOn;

	UIImageView *markerImage;
	UIImageView *clipImage;
	UITextField *disasterMemo;
	
	int         actionMode;			// 0:カメラ 1:位置情報 9:送信
	BOOL        locationFlag;
	BOOL        photoFlag;
	UIImage     *orgImage;
	CLLocationCoordinate2D presentLocation;
	
	
	CLLocationManager      *locationManager;	// 現在地情報取得
	CLLocationCoordinate2D location;
	
	CommonScrollView *disasterInfoView;
}

@property (nonatomic, retain) DisasterPickerView *pickerView;
@property (nonatomic, retain) UIButton *photoViewOff;
@property (nonatomic, retain) UIButton *photoViewOn;
@property (nonatomic, retain) UIButton *locationViewOff;
@property (nonatomic, retain) UIButton *locationViewOn;

@property (nonatomic, retain) UIImageView *markerImage;
@property (nonatomic, retain) UIImageView *clipImage;
@property (nonatomic, retain) UIImage     *orgImage;
@property (nonatomic, retain) UITextField *disasterMemo;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CommonScrollView *disasterInfoView;


- (id)initDisasterInfoSendView:(DisastersInfo *)selectedDisasterMng;
- (void)requestDisasterInfoSend;
- (void)postData;

- (void)pushSendButton:(id)sender;
- (void)pushLocationOff:(id)sender;
- (void)pushLocationOn:(id)sender;
- (void)pushPhotoOff:(id)sender;
- (void)pushPhotoOn:(id)sender;

// GPS現在位置取得
- (void)getGpsLocation;
// 現在位置取得確認
- (void)confirmGetLocation;


@end

@interface DisasterInfoSendViewController(Camera) <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end
