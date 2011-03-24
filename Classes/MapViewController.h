//
//  MapViewController.h
//  Scope2
//	(21)地図画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CommonViewController.h"

@class PlacesInfo;
@interface MapViewController : CommonViewController <MKMapViewDelegate> {
	MKMapView              *mkMapView;
	NSMutableArray         *mapInfoArray;	// マップ情報格納配列
	PlacesInfo *placesInfo;

	int actionMode;			// 0:世帯一覧から 1:家族一覧から 2:個人情報から
	NSString *searchId;			// 検索ID

}

@property (nonatomic, retain) MKMapView *mkMapView;
@property (nonatomic, retain) NSMutableArray *mapInfoArray;
@property (nonatomic, retain) NSString *searchId;

- (id)initMapWithGroupId:(NSString *)grpId;
- (id)initMapWithFamilyId:(NSString *)fmlyId;
- (id)initMapWithPersonalId:(NSString *)prsnlId;
- (id)initMapWithDisaster;
- (id)initMapWithDisasterPersonalId:(NSString *)prsnlId;

- (void)requestMapInfo;
- (void)displayAnnotations;
@end

@interface MapViewController(Xml)
@end
