//
//  PersonalsInfo.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamiliesInfo.h"

@interface PersonalsInfo : FamiliesInfo {
	NSString *personalId;			// 個人ID
	NSString *login;				// ログインID
	NSString *password;				// パスワード
	NSString *fullName;				// 氏名
	NSString *birthday;				// 生年月日
	NSString *sex;					// 性別
	NSString *blood;				// 血液型
	NSString *personalTel;			// 個人電話番号
	NSString *job;					// 職業
	NSString *goodField;			// 得意分野
	NSString *medicalHistory;		// 既往歴
	NSString *iconPath;				// アイコン

	NSString *age;					// 年齢
	NSString *disasterMemo;			// 災害メモ
	NSString *accessKind;			// アクセス制御
}

@property (nonatomic, retain) NSString *personalId;
@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *fullName;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *blood;
@property (nonatomic, retain) NSString *personalTel;
@property (nonatomic, retain) NSString *job;
@property (nonatomic, retain) NSString *goodField;
@property (nonatomic, retain) NSString *medicalHistory;
@property (nonatomic, retain) NSString *iconPath;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *disasterMemo;
@property (nonatomic, retain) NSString *accessKind;

@end
