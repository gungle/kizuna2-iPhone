//
//  FamiliesInfo.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsInfo.h"

@interface FamiliesInfo : GroupsInfo {
	NSString *familyId;			// 家族ID
	NSString *familyName;		// 家族名
	NSString *address;			// 住所
	NSString *homeTel;			// 代表電話番号
	NSString *homeLat;			// 住居位置　緯度
	NSString *homeLon;			// 住居位置　経度
	NSString *weakKind;			// 災害弱者種別
	NSString *personNum;		// 人数
}

@property (nonatomic, retain) NSString *familyId;
@property (nonatomic, retain) NSString *familyName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *homeTel;
@property (nonatomic, retain) NSString *homeLat;
@property (nonatomic, retain) NSString *homeLon;
@property (nonatomic, retain) NSString *weakKind;
@property (nonatomic, retain) NSString *personNum;

@end
