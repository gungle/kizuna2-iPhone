//
//  PropertiesUtil.m
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import "PropertiesUtil.h"


@implementation PropertiesUtil


/**
 * 指定したキーの値を取得する
 */
+ (NSString *)getProperties:(NSString *)key {
	NSString *scopePlist = [[NSBundle mainBundle]pathForResource:@"scope2" ofType:@"plist"];
	NSDictionary *scopeDict = [NSDictionary dictionaryWithContentsOfFile:scopePlist];
	return [scopeDict objectForKey:key];
}

/**
 * 指定したキーの配列を取得する
 */
+ (NSArray *)getPropertiesArray:(NSString *)key {
	return (NSArray*)[self getProperties:key];
}

/**
 * 指定したキーとインデックス値から値を取得する
 */
+ (NSString *)getProperties:(NSString *)key index:(NSInteger)index {
//	NSArray *array = (NSArray*)[self getProperties:key];
	return [[self getPropertiesArray:key] objectAtIndex:index];
}

/**
 * 指定したキーの辞書を取得する
 */
+ (NSDictionary *)getPropertiesDictionary:(NSString *)key {
	return (NSDictionary*)[self getProperties:key];
}

/**
 * 指定したキーと項目名から値を取得する
 */
+ (NSString *)getProperties:(NSString *)key propertyName:(NSString*)propertyName {
	
	NSDictionary *dic = (NSDictionary*)[self getProperties:key];
	return [dic objectForKey:[NSString stringWithString:propertyName]];
}

/**
 * 指定したキーとインデックス値（項目名）から値を取得する
 */
+ (NSString *)getProperties:(NSString *)key indexName:(NSInteger)indexName {
	
	NSDictionary *dic = (NSDictionary*)[self getProperties:key];
	return [dic objectForKey:[NSString stringWithFormat:@"%d",indexName]];
}

- (void)dealloc {
    [super dealloc];
}


@end
