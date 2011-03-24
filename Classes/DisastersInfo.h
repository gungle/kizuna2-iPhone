//
//  DisastersInfo.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonalsInfo.h"


@interface DisastersInfo : PersonalsInfo {
	NSString *emergencyKind;		// 緊急度種別
	NSString *disasterStatusKind;	// 災害状況種別
	NSString *triageKind;			// トリアージ種別
	NSString *doneKind;				// 対応有無種別
	NSString *nowLat;				// 現在位置　緯度
	NSString *nowLon;				// 現在位置　経度
	NSString *picturePath;			// 写真パス
	NSString *personalSafetyKind;	// 個人安否種別
	NSString *status;				// 家族安否種別
	NSString *safetyMode;			// 
}

@property (nonatomic, retain) NSString *emergencyKind;
@property (nonatomic, retain) NSString *disasterStatusKind;
@property (nonatomic, retain) NSString *triageKind;
@property (nonatomic, retain) NSString *doneKind;
@property (nonatomic, retain) NSString *nowLat;
@property (nonatomic, retain) NSString *nowLon;
@property (nonatomic, retain) NSString *picturePath;
@property (nonatomic, retain) NSString *personalSafetyKind;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *safetyMode;


@end
