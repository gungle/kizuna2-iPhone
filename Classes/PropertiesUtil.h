//
//  PropertiesUtil.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PropertiesUtil : NSObject {

}

+ (NSString *)getProperties:(NSString *)key;
+ (NSString *)getProperties:(NSString *)key index:(NSInteger)index;
+ (NSArray *)getPropertiesArray:(NSString *)key;

+ (NSDictionary *)getPropertiesDictionary:(NSString *)key;
+ (NSString *)getProperties:(NSString *)key propertyName:(NSString*)propertyName;
+ (NSString *)getProperties:(NSString *)key indexName:(NSInteger)indexName;

@end
