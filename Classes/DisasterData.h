//
//  DisasterData.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/21.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupsInfo.h"

@interface DisasterData : GroupsInfo {
	NSString *sectionKind;
	NSMutableArray *subItems;
}

@property (nonatomic, retain) NSString *sectionKind;
@property (nonatomic, retain) NSMutableArray *subItems;

@end
