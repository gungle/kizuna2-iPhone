//
//  PlacesInfo.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsInfo.h"
#import <CoreLocation/CoreLocation.h>


@interface PlacesInfo : GroupsInfo {
	NSString *placeId;				// 地図ID
	NSString *placeKind;			// 地図種別
	NSString *placeTitle;			// タイトル
	NSString *placeExplain;			// 詳細情報
	NSString *placeLat;				// 現在位置　緯度
	NSString *placeLon;				// 現在位置　経度
	NSString *picturePath;			// 写真パス
	
	NSString *mapTitle;				// 地図タイトル
	CLLocationCoordinate2D nowLocation;
	
}

@property (nonatomic, retain) NSString *placeId;
@property (nonatomic, retain) NSString *placeKind;
@property (nonatomic, retain) NSString *placeTitle;
@property (nonatomic, retain) NSString *placeExplain;
@property (nonatomic, retain) NSString *placeLat;
@property (nonatomic, retain) NSString *placeLon;
@property (nonatomic, retain) NSString *picturePath;

@property (nonatomic, retain) NSString *mapTitle;
@property (nonatomic) CLLocationCoordinate2D nowLocation;

- (CLLocationCoordinate2D)getNowCoordinate;

@end
