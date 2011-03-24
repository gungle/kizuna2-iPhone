//
//  MapAnnotation.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum MapAnnotationType {
	MapAnnotationTypeRed = 0,
	MapAnnotationTypeGreen,
	MapAnnotationTypePurple,
	MapAnnotationTypeNormal = 11,			// 人（通常）
	MapAnnotationTypeWeak,					// 人（災害弱者）
	MapAnnotationTypeVictim,				// 人（被災者）
	MapAnnotationTypeHome,					// 家
	MapAnnotationTypeEvacuationArea,		// 避難場所
	MapAnnotationTypeHospital,				// 病院
	MapAnnotationTypeDangerZone,			// 危険箇所
	MapAnnotationTypeFamily = 21			// 世帯？？
} MapAnnotationType;

@interface MapAnnotation : NSObject <MKAnnotation>{
	int      annotationId;					// ID
	NSString *title;						// タイトル
	NSString *subtitle;						// タイトル
	NSString *posKind;						// 種別
	NSString *posLat;						// 現在位置　緯度
	NSString *posLon;						// 現在位置　経度	
	CLLocationCoordinate2D coordinate;		// 緯度／経度
	BOOL     centerFlag;					// 中心（1:地図の中心にする）
	MapAnnotationType annotationType;
}

@property (nonatomic) int annotationId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;
@property (nonatomic, retain) NSString *posKind;
@property (nonatomic, retain) NSString *posLat;
@property (nonatomic, retain) NSString *posLon;
@property (nonatomic) MapAnnotationType annotationType;

-(void)setCoordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)coordinateVal;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coord 
					title:(NSString *)annTitle 
					subtitle:(NSString *)annSubtitle
					annotationType:(MapAnnotationType)type;

@end
