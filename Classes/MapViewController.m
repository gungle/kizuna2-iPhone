//
//  MapViewController.m
//  Scope2
//	(21)地図画面
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "MapViewController.h"
#import "PlacesInfo.h"
#import "MapAnnotation.h"


@implementation MapViewController

@synthesize mkMapView;
@synthesize mapInfoArray;
@synthesize searchId;


- (id)init {
	if (self = [super init]) {
		displayId = DISPLAY_ID_21;
		self.title = [self getProperties:@"DISPLAY_TITLE" indexName:displayId];
		self.mapInfoArray = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

// 世帯一覧画面から遷移時
- (id)initMapWithGroupId:(NSString *)grpId {
	if (self = [self init]) {
		actionMode = 0;
		searchId = [[NSString alloc]initWithString:grpId];
	}
	return self;
}

// 家族一覧画面から遷移時
- (id)initMapWithFamilyId:(NSString *)fmlyId {
	if (self = [self init]) {
		actionMode = 1;
		searchId = [[NSString alloc]initWithString:fmlyId];
	}	
	return self;
}

// 個人情報画面から遷移時
- (id)initMapWithPersonalId:(NSString *)prsnlId {
	if (self = [self init]) {
		actionMode = 2;
		searchId = [[NSString alloc]initWithString:prsnlId];
	}
	return self;
}

// 災害一覧画面から遷移時
- (id)initMapWithDisaster {
	if (self = [self init]) {
		actionMode = 3;
	}
	return self;
}

// 災害情報画面から遷移時
- (id)initMapWithDisasterPersonalId:(NSString *)prsnlId {
	if (self = [self init]) {
		actionMode = 4;
		searchId = [[NSString alloc]initWithString:prsnlId];
	}
	return self;
}


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
	 mkMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 372.0f)];
	 mkMapView.delegate = self;
	 //	mkMapView.showsUserLocation = YES;
	 [self.view addSubview:mkMapView];
	 
	 [self requestMapInfo];
 }

/*
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[mapInfoArray removeAllObjects];
	// 更新後の再表示対応
	
	[self requestMapInfo];
}
*/

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
	[searchId release];
	[mapInfoArray removeAllObjects];
	[mapInfoArray release];
	[mkMapView release];
    [super dealloc];
}

- (void)requestMapInfo {
	// Table
	NSError *parseError = nil;  
	// TODO 遷移元画面によってパラメターを変更すること
	
	//------------------------------
	// 6.1 位置情報一覧・詳細取得リクエスト 
	//------------------------------
	
	NSString *url;
	NSString *parameter;
	if (actionMode == 0) {
		// 世帯一覧画面
		parameter = [NSString stringWithFormat:@"group_id=%@",searchId];
	} else if (actionMode == 1) {
		// 家族一覧画面
		parameter = [NSString stringWithFormat:@"family_id=%@",searchId];
	} else if (actionMode == 2) {
		// 個人情報画面
		parameter = [NSString stringWithFormat:@"personal_id=%@",searchId];
	} else if (actionMode == 3) {
		// 災害情報一覧画面
		parameter = [NSString stringWithString:@"disaster=all"];
	} else if (actionMode == 4) {
		// 災害情報画面
		parameter = [NSString stringWithFormat:@"disaster=one&personal_id=%@",searchId];
	}
	url = [[NSString alloc]initWithFormat:@"%@%@?%@",
#if TARGET_IPHONE_SIMULATOR
		   [self getProperties:@"SERVER_DEBUG"], 
#else
		   [self getProperties:@"SERVER"], 
#endif
		   [self getProperties:@"API_KEY_PLACES"],
		   parameter];
	

	[self parseXMLFileAtURL:[NSURL URLWithString:url] parseError:&parseError];
	[url release];
}

- (void)displayAnnotations {
	MapAnnotation *pinAnnotation = nil;
	CLLocationCoordinate2D loc;
	MapAnnotationType annotationType;
	int placeCount = 0;
	for (PlacesInfo *info in mapInfoArray) {
		
		if ([info.placeKind isEqualToString:@"11"]) {
			// 人（通常）
//			annotationType = MapAnnotationTypeGreen;
			annotationType = MapAnnotationTypeNormal;
		} else if ([info.placeKind isEqualToString:@"12"]) {
			// 人（災害弱者）
//			annotationType = MapAnnotationTypePurple;
			annotationType = MapAnnotationTypeWeak;
		} else if ([info.placeKind isEqualToString:@"13"]) {
			// 人（被災者）
//			annotationType = MapAnnotationTypeRed;
			annotationType = MapAnnotationTypeVictim;
		} else if ([info.placeKind isEqualToString:@"14"]) {
			// 家
			annotationType = MapAnnotationTypeHome;
		} else if ([info.placeKind isEqualToString:@"15"]) {
			// 避難場所
			annotationType = MapAnnotationTypeEvacuationArea;
		} else if ([info.placeKind isEqualToString:@"16"]) {
			// 病院
			annotationType = MapAnnotationTypeHospital;
		} else if ([info.placeKind isEqualToString:@"17"]) {
			// 災害箇所
			annotationType = MapAnnotationTypeDangerZone;
		} else if ([info.placeKind isEqualToString:@"21"]) {
			// 世帯？
			annotationType = MapAnnotationTypeFamily;
		} else {
			annotationType = MapAnnotationTypeGreen;
		}


		pinAnnotation = [[MapAnnotation alloc] 
						 initWithCoordinate:[info getNowCoordinate]
						 title:[NSString stringWithFormat:@"%@",info.placeTitle]
						 subtitle:[NSString stringWithFormat:@"%@",info.placeExplain]
						 annotationType:annotationType];
		pinAnnotation.posKind = [NSString stringWithFormat:@"%@",info.placeKind];
		[mkMapView addAnnotation:pinAnnotation];
		[pinAnnotation release];
		
		if (placeCount == 0) {
			// 地図の中心に設定する
			loc = [info getNowCoordinate];
		}
		placeCount++;
	}
//	MKCoordinateRegion region;
//	MKCoordinateSpan   span;
//	span.latitudeDelta  = MAP_SPAN_DELTA_LAT;
//	span.longitudeDelta = MAP_SPAN_DELTA_LON;
//	region.span = span;	
//	region.center = loc;
	MKCoordinateSpan span = MKCoordinateSpanMake(MAP_SPAN_DELTA_LAT, MAP_SPAN_DELTA_LON);
//	CLLocationCoordinate2D centerCoordinate = loc.coordinate;
	MKCoordinateRegion region =	MKCoordinateRegionMake(loc, span);
	[mkMapView setRegion:region animated:YES];

	[mkMapView setNeedsDisplay];
}

#pragma mark -
#pragma mark MKMapViewDelegate methods
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//	NSLog(@"lat > %f",mapView.region.span.latitudeDelta);
//	NSLog(@"lon > %f",mapView.region.span.longitudeDelta);
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{

	MKPinAnnotationView *annView;
	annView = (MKPinAnnotationView*)[mkMapView dequeueReusableAnnotationViewWithIdentifier:@"currentloc"];
	
	if(nil == annView) {
		annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
	}
	if([annotation isKindOfClass:[MapAnnotation class]]) {
		MapAnnotationType annotationType = [(MapAnnotation *)annotation annotationType];
		if (annotationType == MapAnnotationTypeNormal) {
			// 人（通常）
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_NORMAL];
		} else if (annotationType == MapAnnotationTypeWeak) {
			// 人（災害弱者）
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_WEAK];
		} else if (annotationType == MapAnnotationTypeVictim) {
			// 人（被災者）
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_VICTIM];
		} else if (annotationType == MapAnnotationTypeHome) {
			// 家
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_HOME];
		} else if (annotationType == MapAnnotationTypeEvacuationArea) {
			// 避難場所
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_EVACUATION_AREA];
		} else if (annotationType == MapAnnotationTypeHospital) {
			// 病院
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_HOSPITAL];
		} else if (annotationType == MapAnnotationTypeDangerZone) {
			// 危険箇所
			annView.image = [UIImage imageNamed:ICON_NAME_MAP_DANGER_ZONE];
//		} else if (annotationType == MapAnnotationTypeFamily) {
//			// 世帯？
//			annView.image = [UIImage imageNamed:ICON_NAME_MAP_DANGER_ZONE];
		} else {
			annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
			annView.pinColor = annotationType;
			annView.animatesDrop=YES;
//			annView.canShowCallout = YES;
//			annView.calloutOffset = CGPointMake(-5, 5);
		}
	}
	annView.canShowCallout = YES;
	annView.calloutOffset = CGPointMake(-5, 5);
	

//	UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//	annView.rightCalloutAccessoryView = button;
	return annView;
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	// 次の画面で画像表示またはこの画面でModalViewに画像表示
	/*
	 MapInfoViewController *mapInfoViewController = [[MapInfoViewController alloc] initWithImagePath:[(MapInfo *)view.annotation picturePath]];
	 mapInfoViewController.title = @"詳細画像";
	 [self.navigationController pushViewController:mapInfoViewController animated:YES];
	 */	
}

@end
