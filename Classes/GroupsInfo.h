//
//  GroupsInfo.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GroupsInfo : NSObject {
	NSString *groupId;			// 組みID
	NSString *groupName;		// 組名
	NSString *updatedAt;		// 最終更新日時
	NSString *familyNumber;		// 組内世帯数
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *updatedAt;
@property (nonatomic, retain) NSString *familyNumber;

@end
