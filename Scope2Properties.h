//
//  Scope2Properties.h
//  Scope2
//
//  Created by YOSHIDA Hiroyuki on 10/09/01.
//  Copyright Institute for HyperNetwork Society 2010. All rights reserved.
//

//----------------------------------------------------
// DISPLAY ID
//----------------------------------------------------
#define DISPLAY_ID_01              1	// 組情報一覧
#define DISPLAY_ID_02              2	// 世帯一覧
#define DISPLAY_ID_03              3	// 家族一覧
#define DISPLAY_ID_04              4	// 個人情報
#define DISPLAY_ID_11              11	// 災害情報一覧
#define DISPLAY_ID_12              12	// 災害情報
#define DISPLAY_ID_13              13	// 被災者情報（災害情報送信）
#define DISPLAY_ID_14              14	// 安否確認
#define DISPLAY_ID_15              15	// 災害情報（画像表示）
#define DISPLAY_ID_21              21	// 地図
#define DISPLAY_ID_31              31	// 設定

//----------------------------------------------------
// XML ELEMNENT NAMES
//----------------------------------------------------
#define ELEMENT_NAME_ACCESS_KIND          @"access_kind"
#define ELEMENT_NAME_ADDRESS              @"address"
#define ELEMENT_NAME_AGE                  @"age"
#define ELEMENT_NAME_BLOOD                @"blood"
#define ELEMENT_NAME_DEVICETOKEN          @"devicetoken"
#define ELEMENT_NAME_DEVICE_TOKEN         @"device_token"
#define ELEMENT_NAME_DISASTER             @"disaster"
#define ELEMENT_NAME_DISASTERS            @"disasters"
#define ELEMENT_NAME_DISASTER_MEMO        @"disaster_memo"
#define ELEMENT_NAME_DISASTER_STATUS_KIND @"disaster_status_kind"
#define ELEMENT_NAME_DONE_KIND            @"done_kind"
#define ELEMENT_NAME_EMERGENCY_KIND       @"emergency_kind"
#define ELEMENT_NAME_FAMILIES             @"families"
#define ELEMENT_NAME_FAMILY               @"family"
#define ELEMENT_NAME_FAMILY_ID            @"family_id"
#define ELEMENT_NAME_FAMILY_NAME          @"family_name"
#define ELEMENT_NAME_FAMILY_NUMBER        @"family_number"
//#define ELEMENT_NAME_FAMILY_SAFETY_KIND   @"family_safety_kind"
#define ELEMENT_NAME_FULL_NAME            @"full_name"
#define ELEMENT_NAME_GOOD_FIELD           @"good_field"
#define ELEMENT_NAME_GROUP                @"group"
#define ELEMENT_NAME_GROUP_ID             @"group_id"
#define ELEMENT_NAME_GROUP_NAME           @"group_name"
#define ELEMENT_NAME_GROUPS               @"groups"
#define ELEMENT_NAME_HELPS                @"helps"
#define ELEMENT_NAME_HELP                 @"help"
#define ELEMENT_NAME_HOME_LAT             @"home_lat"
#define ELEMENT_NAME_HOME_LON             @"home_lon"
#define ELEMENT_NAME_HOME_TEL             @"home_tel"
#define ELEMENT_NAME_ICON_PATH            @"icon_path"
#define ELEMENT_NAME_JOB                  @"job"
#define ELEMENT_NAME_LOGIN                @"login"
#define ELEMENT_NAME_MEDICAL_HISTORY      @"medical_history"
#define ELEMENT_NAME_MESSAGE              @"message"
#define ELEMENT_NAME_MODE                 @"mode"
#define ELEMENT_NAME_PERSONAL             @"personal"
#define ELEMENT_NAME_PERSONAL_ID          @"personal_id"
#define ELEMENT_NAME_PERSONAL_SAFETY_KIND @"personal_safety_kind"
#define ELEMENT_NAME_PERSONAL_TEL         @"personal_tel"
#define ELEMENT_NAME_PERSONALS            @"personals"
#define ELEMENT_NAME_PICTURE_PATH         @"picture_path"
#define ELEMENT_NAME_PLACES               @"places"
#define ELEMENT_NAME_PLACE                @"place"
#define ELEMENT_NAME_PLACE_ID             @"place_id"
#define ELEMENT_NAME_PLACE_TITLE          @"place_title"
#define ELEMENT_NAME_PLACE_EXPLAIN        @"place_explain"
#define ELEMENT_NAME_PLACE_KIND           @"place_kind"
#define ELEMENT_NAME_PLACE_LAT            @"place_lat"
#define ELEMENT_NAME_PLACE_LON            @"place_lon"
#define ELEMENT_NAME_RESULT               @"result"
#define ELEMENT_NAME_RESULTS              @"results"
#define ELEMENT_NAME_SAFETIES             @"safeties"
#define ELEMENT_NAME_SAFETY               @"safety"
#define ELEMENT_NAME_SEX                  @"sex"
#define ELEMENT_NAME_SHARE_DISASTER_KIND  @"share_disaster_kind"
#define ELEMENT_NAME_STATUS               @"status"
#define ELEMENT_NAME_TRIAGE_KIND          @"triage_kind"
#define ELEMENT_NAME_UPDATED_AT           @"updated_at"
#define ELEMENT_NAME_WEAK                 @"weak"
#define ELEMENT_NAME_WEAKS                @"weaks"
#define ELEMENT_NAME_WEAK_KIND            @"weak_kind"

#define ATTRIBUTE_NAME_MODE               @"mode"


//----------------------------------------------------
// ICON NAME
//----------------------------------------------------
// TAB
#define ICON_NAME_TAB_GROUP               @"groupTab.png"
#define ICON_NAME_TAB_DISASTER            @"disasterTab.png"
#define ICON_NAME_TAB_SETTINGS            @"settingsTab.png"
// 災害情報
#define ICON_NAME_CAMERA_0                @"camera0.jpg"
#define ICON_NAME_CAMERA_1                @"camera1.jpg"
#define ICON_NAME_LOCATION_0              @"location0.jpg"
#define ICON_NAME_LOCATION_1              @"location1.jpg"
#define ICON_NAME_CLIP                    @"clip.png"
#define ICON_NAME_MARKER                  @"marker.png"
#define ICON_NAME_CHECK                   @"checkImage.gif"
#define ICON_NAME_NON_CHECK               @"nonCheckImage.gif"
// 位置情報
#define ICON_NAME_MAP_NORMAL              @"normal.gif"
#define ICON_NAME_MAP_WEAK                @"weak.gif"
#define ICON_NAME_MAP_VICTIM              @"victim.gif"
#define ICON_NAME_MAP_HOME                @"home.gif"
#define ICON_NAME_MAP_DANGER_ZONE         @"dangerZoon.gif"
#define ICON_NAME_MAP_EVACUATION_AREA     @"evacuationArea.gif"
#define ICON_NAME_MAP_HOSPITAL            @"hospital.jpg"
// 性別
#define ICON_NAME_SEX_MAN                 @"man.gif"
#define ICON_NAME_SEX_WOMAN               @"woman.gif"
// トリアージ
#define ICON_NAME_TRIAGE_WHITE            @"triageWhite.png"
#define ICON_NAME_TRIAGE_GREEN            @"triageGreen.png"
#define ICON_NAME_TRIAGE_YELLOW           @"triageYellow.png"
#define ICON_NAME_TRIAGE_RED              @"triageRed.png"
#define ICON_NAME_TRIAGE_BLACK            @"triageBlack.png"

#define ICON_NAME_DISASTER_WEAK           @"disasterWeak.gif"
// 矢印
#define ICON_NAME_ARROW                   @"arrow.png"


//----------------------------------------------------
// SOUND FILE
//----------------------------------------------------
// Push Notification 通知音
#define PUSH_NOTIFICATION_SOUND           @"/System/Library/Audio/UISounds/sms-received1.caf"

//----------------------------------------------------
// 共通
//----------------------------------------------------
#define DEFAULT_TABLE_X         0
#define DEFAULT_TABLE_Y         0
#define DEFAULT_TABLE_WIDTH     320
#define DEFAULT_TABLE_HEIGHT    400
#define DEFAULT_SPAN            5.0

// デフォルトフォントサイズ
#define DEFAULT_FONT_SIZE       22.0
// デフォルトフォントサイズ
#define DEFAULT_FONT_SMALL_SIZE 18.0

// 地図の端から端までの緯度・経度の差の絶対値
#define MAP_SPAN_DELTA          0.005
#define MAP_SPAN_DELTA_LAT      MAP_SPAN_DELTA
#define MAP_SPAN_DELTA_LON      MAP_SPAN_DELTA

//----------------------------------------------------
// 組情報一覧 GroupListViewControllerで使用
//----------------------------------------------------

#define GROUP_LIST_TABLE_CELL_FONT_SIZE         DEFAULT_FONT_SIZE
#define GROUP_LIST_TABLE_CELL_HEIGHT            50
#define GROUP_LIST_TABLE_CELL_SPAN              DEFAULT_SPAN

// テーブルセル　タイトル（組名）
#define GROUP_LIST_TABLE_CELL_TITLE_X            GROUP_LIST_TABLE_CELL_SPAN * 2 
#define GROUP_LIST_TABLE_CELL_TITLE_Y            GROUP_LIST_TABLE_CELL_SPAN
#define GROUP_LIST_TABLE_CELL_TITLE_WIDTH        170.0
#define GROUP_LIST_TABLE_CELL_TITLE_HEIGHT       40
// テーブルセル　サブタイトル（世帯数）
#define GROUP_LIST_TABLE_CELL_SUBTITLE_X         GROUP_LIST_TABLE_CELL_TITLE_X + GROUP_LIST_TABLE_CELL_TITLE_WIDTH + GROUP_LIST_TABLE_CELL_SPAN
#define GROUP_LIST_TABLE_CELL_SUBTITLE_Y         GROUP_LIST_TABLE_CELL_TITLE_Y
#define GROUP_LIST_TABLE_CELL_SUBTITLE_WIDTH     80.0
#define GROUP_LIST_TABLE_CELL_SUBTITLE_HEIGHT    GROUP_LIST_TABLE_CELL_TITLE_HEIGHT


//----------------------------------------------------
// 世帯一覧 FamilyListViewControllerで使用
//----------------------------------------------------

#define FAMILY_LIST_TABLE_CELL_FONT_SIZE         DEFAULT_FONT_SIZE
#define FAMILY_LIST_TABLE_CELL_SMALL_FONT_SIZE   DEFAULT_FONT_SMALL_SIZE
#define FAMILY_LIST_TABLE_CELL_HEIGHT            76
#define FAMILY_LIST_TABLE_CELL_SPAN              3.0

// テーブルセル　アイコン
#define FAMILY_LIST_TABLE_CELL_ICON_WIDTH        40.0
#define FAMILY_LIST_TABLE_CELL_ICON_HEIGHT       40.0
#define FAMILY_LIST_TABLE_CELL_ICON_X            FAMILY_LIST_TABLE_CELL_SPAN
#define FAMILY_LIST_TABLE_CELL_ICON_Y            (FAMILY_LIST_TABLE_CELL_HEIGHT - FAMILY_LIST_TABLE_CELL_ICON_HEIGHT) / 2
// テーブルセル　タイトル（世帯名）
#define FAMILY_LIST_TABLE_CELL_TITLE_X            FAMILY_LIST_TABLE_CELL_SPAN * 2 + FAMILY_LIST_TABLE_CELL_ICON_WIDTH
#define FAMILY_LIST_TABLE_CELL_TITLE_Y            FAMILY_LIST_TABLE_CELL_SPAN
#define FAMILY_LIST_TABLE_CELL_TITLE_WIDTH        170.0
#define FAMILY_LIST_TABLE_CELL_TITLE_HEIGHT       24.0
// テーブルセル　サブタイトル（人数）
#define FAMILY_LIST_TABLE_CELL_SUBTITLE_X         FAMILY_LIST_TABLE_CELL_TITLE_X + FAMILY_LIST_TABLE_CELL_TITLE_WIDTH + FAMILY_LIST_TABLE_CELL_SPAN
#define FAMILY_LIST_TABLE_CELL_SUBTITLE_Y         FAMILY_LIST_TABLE_CELL_TITLE_Y
#define FAMILY_LIST_TABLE_CELL_SUBTITLE_WIDTH     70.0
#define FAMILY_LIST_TABLE_CELL_SUBTITLE_HEIGHT    FAMILY_LIST_TABLE_CELL_TITLE_HEIGHT
// テーブルセル　サブラベル１（住所）
#define FAMILY_LIST_TABLE_CELL_LABEL1_X			  FAMILY_LIST_TABLE_CELL_TITLE_X
#define FAMILY_LIST_TABLE_CELL_LABEL1_Y           FAMILY_LIST_TABLE_CELL_TITLE_Y + FAMILY_LIST_TABLE_CELL_TITLE_HEIGHT + FAMILY_LIST_TABLE_CELL_SPAN
#define FAMILY_LIST_TABLE_CELL_LABEL1_WIDTH       250.0
#define FAMILY_LIST_TABLE_CELL_LABEL1_HEIGHT      20
// テーブルセル　サブラベル２（電話番号）
#define FAMILY_LIST_TABLE_CELL_LABEL2_X           FAMILY_LIST_TABLE_CELL_TITLE_X
#define FAMILY_LIST_TABLE_CELL_LABEL2_Y           FAMILY_LIST_TABLE_CELL_LABEL1_Y + FAMILY_LIST_TABLE_CELL_LABEL1_HEIGHT + FAMILY_LIST_TABLE_CELL_SPAN
#define FAMILY_LIST_TABLE_CELL_LABEL2_WIDTH       250.0
#define FAMILY_LIST_TABLE_CELL_LABEL2_HEIGHT      FAMILY_LIST_TABLE_CELL_LABEL1_HEIGHT

//----------------------------------------------------
// 家族一覧 PersonalListViewControllerで使用
//----------------------------------------------------
#define PERSONAL_LIST_TABLE_CELL_FONT_SIZE         DEFAULT_FONT_SIZE
#define PERSONAL_LIST_TABLE_CELL_HEIGHT            50
#define PERSONAL_LIST_TABLE_CELL_SPAN              3.0

// テーブルセル　アイコン
#define PERSONAL_LIST_TABLE_CELL_ICON_X            PERSONAL_LIST_TABLE_CELL_SPAN
#define PERSONAL_LIST_TABLE_CELL_ICON_Y            PERSONAL_LIST_TABLE_CELL_SPAN
#define PERSONAL_LIST_TABLE_CELL_ICON_WIDTH        40.0
#define PERSONAL_LIST_TABLE_CELL_ICON_HEIGHT       40.0
// テーブルセル　タイトル（氏名）
#define PERSONAL_LIST_TABLE_CELL_TITLE_X            PERSONAL_LIST_TABLE_CELL_SPAN * 2 + PERSONAL_LIST_TABLE_CELL_ICON_WIDTH
#define PERSONAL_LIST_TABLE_CELL_TITLE_Y            PERSONAL_LIST_TABLE_CELL_SPAN
#define PERSONAL_LIST_TABLE_CELL_TITLE_WIDTH        170.0
#define PERSONAL_LIST_TABLE_CELL_TITLE_HEIGHT       PERSONAL_LIST_TABLE_CELL_ICON_HEIGHT
// テーブルセル　サブタイトル（性別）(使用していないが、整列のためそのままにしている)
#define PERSONAL_LIST_TABLE_CELL_SUBTITLE_X         PERSONAL_LIST_TABLE_CELL_TITLE_X + PERSONAL_LIST_TABLE_CELL_TITLE_WIDTH + PERSONAL_LIST_TABLE_CELL_SPAN
#define PERSONAL_LIST_TABLE_CELL_SUBTITLE_Y         DEFAULT_SPAN
#define PERSONAL_LIST_TABLE_CELL_SUBTITLE_WIDTH     35
#define PERSONAL_LIST_TABLE_CELL_SUBTITLE_HEIGHT    PERSONAL_LIST_TABLE_CELL_TITLE_HEIGHT
// テーブルセル　性別アイコン
#define PERSONAL_LIST_TABLE_CELL_SEX_ICON_X        PERSONAL_LIST_TABLE_CELL_TITLE_X + PERSONAL_LIST_TABLE_CELL_TITLE_WIDTH
#define PERSONAL_LIST_TABLE_CELL_SEX_ICON_Y        DEFAULT_SPAN * 2
#define PERSONAL_LIST_TABLE_CELL_SEX_ICON_WIDTH    18.0
#define PERSONAL_LIST_TABLE_CELL_SEX_ICON_HEIGHT   28.0
// テーブルセル　サブラベル１（年齢）
#define PERSONAL_LIST_TABLE_CELL_LABEL1_X			PERSONAL_LIST_TABLE_CELL_SEX_ICON_X + PERSONAL_LIST_TABLE_CELL_SEX_ICON_WIDTH + DEFAULT_SPAN
#define PERSONAL_LIST_TABLE_CELL_LABEL1_Y           DEFAULT_SPAN
#define PERSONAL_LIST_TABLE_CELL_LABEL1_WIDTH       50.0
#define PERSONAL_LIST_TABLE_CELL_LABEL1_HEIGHT      PERSONAL_LIST_TABLE_CELL_TITLE_HEIGHT


//----------------------------------------------------
// 個人情報 PersonalsInformationViewControllerで使用
//----------------------------------------------------
#define PERSONAL_INFO_FONT_SIZE                    DEFAULT_FONT_SIZE
#define PERSONAL_INFO_TABLE_CELL_HEIGHT            100.0
#define PERSONAL_INFO_SPAN_Y                       DEFAULT_SPAN

// ユーザアイコンイメージ
#define PERSONAL_INFO_USER_ICON_X                  10.0
#define PERSONAL_INFO_USER_ICON_Y                  10.0
#define PERSONAL_INFO_USER_ICON_WIDTH              100.0
#define PERSONAL_INFO_USER_ICON_HEIGHT             100.0
// 氏名ラベル
#define PERSONAL_INFO_FULL_NAME_LABEL_X            PERSONAL_INFO_USER_ICON_X + PERSONAL_INFO_USER_ICON_WIDTH + DEFAULT_SPAN
#define PERSONAL_INFO_FULL_NAME_LABEL_Y            PERSONAL_INFO_USER_ICON_Y
#define PERSONAL_INFO_FULL_NAME_LABEL_WIDTH        160.0
#define PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT       30.0
// 災害弱者マークイメージ
#define PERSONAL_INFO_DISASTER_MARK_X              PERSONAL_INFO_FULL_NAME_LABEL_X + PERSONAL_INFO_FULL_NAME_LABEL_WIDTH   
#define PERSONAL_INFO_DISASTER_MARK_Y              10.0
#define PERSONAL_INFO_DISASTER_MARK_WIDTH          40.0
#define PERSONAL_INFO_DISASTER_MARK_HEIGHT         40.0
// 性別ラベル(使用していないが、整列のためそのままにしている)
#define PERSONAL_INFO_SEX_LABEL_X                  PERSONAL_INFO_FULL_NAME_LABEL_X
#define PERSONAL_INFO_SEX_LABEL_Y                  PERSONAL_INFO_SPAN_Y + PERSONAL_INFO_FULL_NAME_LABEL_Y + PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
#define PERSONAL_INFO_SEX_LABEL_WIDTH              30.0
#define PERSONAL_INFO_SEX_LABEL_HEIGHT             PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
// 性別アイコン
#define PERSONAL_INFO_SEX_ICON_X                  PERSONAL_INFO_FULL_NAME_LABEL_X
#define PERSONAL_INFO_SEX_ICON_Y                  PERSONAL_INFO_SPAN_Y + PERSONAL_INFO_FULL_NAME_LABEL_Y + PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
#define PERSONAL_INFO_SEX_ICON_WIDTH              18.0
#define PERSONAL_INFO_SEX_ICON_HEIGHT             28.0
// 年齢ラベル
#define PERSONAL_INFO_AGE_LABEL_X                  30.0 + PERSONAL_INFO_FULL_NAME_LABEL_X + PERSONAL_INFO_SEX_LABEL_WIDTH
#define PERSONAL_INFO_AGE_LABEL_Y                  PERSONAL_INFO_SEX_LABEL_Y
#define PERSONAL_INFO_AGE_LABEL_WIDTH              55.0
#define PERSONAL_INFO_AGE_LABEL_HEIGHT             PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
// 血液型ラベル
#define PERSONAL_INFO_BLOOD_LABEL_X                DEFAULT_SPAN + PERSONAL_INFO_AGE_LABEL_X + PERSONAL_INFO_AGE_LABEL_WIDTH
#define PERSONAL_INFO_BLOOD_LABEL_Y                PERSONAL_INFO_AGE_LABEL_Y
#define PERSONAL_INFO_BLOOD_LABEL_WIDTH            50.0     
#define PERSONAL_INFO_BLOOD_LABEL_HEIGHT           PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
// 電話番号ラベル
#define PERSONAL_INFO_TEL_LABEL_X                  PERSONAL_INFO_FULL_NAME_LABEL_X
#define PERSONAL_INFO_TEL_LABEL_Y                  PERSONAL_INFO_SPAN_Y + PERSONAL_INFO_BLOOD_LABEL_Y + PERSONAL_INFO_BLOOD_LABEL_HEIGHT
#define PERSONAL_INFO_TEL_LABEL_WIDTH              170.0
#define PERSONAL_INFO_TEL_LABEL_HEIGHT             PERSONAL_INFO_FULL_NAME_LABEL_HEIGHT
// テーブル
#define PERSONAL_INFO_TABLE_X                      0.0
#define PERSONAL_INFO_TABLE_Y                      PERSONAL_INFO_SPAN_Y + PERSONAL_INFO_TEL_LABEL_Y + PERSONAL_INFO_TEL_LABEL_HEIGHT
#define PERSONAL_INFO_TABLE_WIDTH                  320.0
#define PERSONAL_INFO_TABLE_HEIGHT                 400.0

//----------------------------------------------------
// 災害一覧 DisasterListViewControllerで使用
//----------------------------------------------------
#define DISASTER_LIST_TABLE_CELL_FONT_SIZE         DEFAULT_FONT_SIZE
#define DISASTER_LIST_TABLE_CELL_SMALL_FONT_SIZE   DEFAULT_FONT_SMALL_SIZE
#define DISASTER_LIST_TABLE_CELL_HEIGHT            76.0
#define DISASTER_LIST_TABLE_CELL_SPAN              3.0

// テーブルヘッダー
#define DISASTER_LIST_TABLE_HEADER_HEIGHT          35.0
// カスタムツールバー（安否確認、被災者入力ボタン）
#define DISASTER_LIST_TABLE_TOOLBAR_WIDTH          260.0
#define DISASTER_LIST_TABLE_TOOLBAR_HEIGHT         44.4
#define DISASTER_LIST_TABLE_TOOLBAR_VIEW_X         0.0
#define DISASTER_LIST_TABLE_TOOLBAR_VIEW_Y         0.0
#define DISASTER_LIST_TABLE_TOOLBAR_X              -10.0
#define DISASTER_LIST_TABLE_TOOLBAR_Y              0.0

// テーブル更新トリガー
#define DISASTER_LIST_OFFSET_Y                     60.0
#define DISASTER_LIST_TABLE_TRIGGER_WIDTH          120.0
#define DISASTER_LIST_TABLE_TRIGGER_HEIGHT         40.0
#define DISASTER_LIST_TRIGGER_ARROW_WIDTH          20.0
#define DISASTER_LIST_TRIGGER_ARROW_HEIGHT         38.0
#define DISASTER_LIST_TRIGGER_ARROW_X              20.0
#define DISASTER_LIST_TRIGGER_ARROW_Y              (DISASTER_LIST_TABLE_TRIGGER_HEIGHT - DISASTER_LIST_TRIGGER_ARROW_HEIGHT) / 2



// テーブルセル　アイコン
#define DISASTER_LIST_TABLE_CELL_ICON_WIDTH        40.0
#define DISASTER_LIST_TABLE_CELL_ICON_HEIGHT       40.0
#define DISASTER_LIST_TABLE_CELL_ICON_X            DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_ICON_Y            (DISASTER_LIST_TABLE_CELL_HEIGHT - DISASTER_LIST_TABLE_CELL_ICON_HEIGHT) / 2
// テーブルセル　タイトル（氏名）
#define DISASTER_LIST_TABLE_CELL_FULL_NAME_X       DISASTER_LIST_TABLE_CELL_SPAN * 2 + DISASTER_LIST_TABLE_CELL_ICON_WIDTH
#define DISASTER_LIST_TABLE_CELL_FULL_NAME_Y       DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_FULL_NAME_WIDTH   180.0
#define DISASTER_LIST_TABLE_CELL_FULL_NAME_HEIGHT  24.0
// テーブルセル　サブタイトル（災害状況種別）
#define DISASTER_LIST_TABLE_CELL_EXPLAIN_X         DISASTER_LIST_TABLE_CELL_FULL_NAME_X
#define DISASTER_LIST_TABLE_CELL_EXPLAIN_Y         DISASTER_LIST_TABLE_CELL_FULL_NAME_Y + DISASTER_LIST_TABLE_CELL_FULL_NAME_HEIGHT + DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_EXPLAIN_WIDTH     250.0
#define DISASTER_LIST_TABLE_CELL_EXPLAIN_HEIGHT    20.0
// テーブルセル　サブラベル１（性別）
#define DISASTER_LIST_TABLE_CELL_SEX_X		       DISASTER_LIST_TABLE_CELL_FULL_NAME_X + DISASTER_LIST_TABLE_CELL_FULL_NAME_WIDTH+ DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_SEX_Y             DISASTER_LIST_TABLE_CELL_FULL_NAME_Y
#define DISASTER_LIST_TABLE_CELL_SEX_WIDTH         35.0
#define DISASTER_LIST_TABLE_CELL_SEX_HEIGHT        DISASTER_LIST_TABLE_CELL_FULL_NAME_HEIGHT
// テーブルセル　性別アイコン
#define DISASTER_LIST_TABLE_CELL_SEX_ICON_X        DISASTER_LIST_TABLE_CELL_FULL_NAME_X + DISASTER_LIST_TABLE_CELL_FULL_NAME_WIDTH+ DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_SEX_ICON_Y        0
#define DISASTER_LIST_TABLE_CELL_SEX_ICON_WIDTH    18.0
#define DISASTER_LIST_TABLE_CELL_SEX_ICON_HEIGHT   28.0
// テーブルセル　サブラベル２（年齢）
#define DISASTER_LIST_TABLE_CELL_AGE_X             DISASTER_LIST_TABLE_CELL_SEX_X + DISASTER_LIST_TABLE_CELL_SEX_WIDTH + DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_AGE_Y             DISASTER_LIST_TABLE_CELL_FULL_NAME_Y
#define DISASTER_LIST_TABLE_CELL_AGE_WIDTH         35.0
#define DISASTER_LIST_TABLE_CELL_AGE_HEIGHT        DISASTER_LIST_TABLE_CELL_FULL_NAME_HEIGHT

// テーブルセル　災害メモ
#define DISASTER_LIST_TABLE_CELL_MEMO_X            DISASTER_LIST_TABLE_CELL_EXPLAIN_X
#define DISASTER_LIST_TABLE_CELL_MEMO_Y            DISASTER_LIST_TABLE_CELL_EXPLAIN_Y + DISASTER_LIST_TABLE_CELL_EXPLAIN_HEIGHT + DISASTER_LIST_TABLE_CELL_SPAN
#define DISASTER_LIST_TABLE_CELL_MEMO_WIDTH        250.0
#define DISASTER_LIST_TABLE_CELL_MEMO_HEIGHT       DISASTER_LIST_TABLE_CELL_EXPLAIN_HEIGHT

// 安否状況 個人 ケガ、不明など
#define DISASTER_LIST_TABLE_CELL_COLOR_SAFETY_MODE_1 [UIColor colorWithRed:1.0 green:0.65 blue:0.0 alpha:1.0]
// 安否状況 家族 報告なし
#define DISASTER_LIST_TABLE_CELL_COLOR_SAFETY_MODE_2 [UIColor colorWithRed:1.0 green:0.93 blue:0.84 alpha:1.0]

// トリアージ１（緑）
#define DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_1      [UIColor colorWithRed:0.60 green:0.97 blue:0.60 alpha:1.0]
// トリアージ２（黄）
#define DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_2      [UIColor colorWithRed:1.0 green:1.0 blue:0.89 alpha:1.0]
// トリアージ３（赤）
#define DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_3      [UIColor colorWithRed:1.0 green:0.71 blue:0.75 alpha:1.0]
// トリアージ４（黒）
#define DISASTER_LIST_TABLE_CELL_COLOR_TRIAGE_4      [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.0]


//----------------------------------------------------
// 災害情報 DisasterInfoViewControllerで使用
//----------------------------------------------------
#define DISASTER_INFO_FONT_SIZE                    DEFAULT_FONT_SIZE
#define DISASTER_INFO_FONT_SMALL_SIZE              DEFAULT_FONT_SMALL_SIZE
#define DISASTER_INFO_SPAN_Y                       DEFAULT_SPAN

// 氏名ラベル
#define DISASTER_INFO_FULL_NAME_LABEL_X                 15.0
#define DISASTER_INFO_FULL_NAME_LABEL_Y                 15.0
#define DISASTER_INFO_FULL_NAME_LABEL_WIDTH             200.0
#define DISASTER_INFO_FULL_NAME_LABEL_HEIGHT            24.0
// 緊急度ラベル
#define DISASTER_INFO_EMERGENCY_KIND_LABEL_X            35.0
#define DISASTER_INFO_EMERGENCY_KIND_LABEL_Y            DISASTER_INFO_FULL_NAME_LABEL_Y + DISASTER_INFO_FULL_NAME_LABEL_HEIGHT + DEFAULT_SPAN
#define DISASTER_INFO_EMERGENCY_KIND_LABEL_WIDTH        250.0
#define DISASTER_INFO_EMERGENCY_KIND_LABEL_HEIGHT       22.0
// 状況ラベル
//#define DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_X      35.0
//#define DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_Y      DISASTER_INFO_SPAN_Y + DISASTER_INFO_FULL_NAME_LABEL_Y + DISASTER_INFO_FULL_NAME_LABEL_HEIGHT
//#define DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_WIDTH  250.0
//#define DISASTER_INFO_DISASTER_STATUS_KIND_LABEL_HEIGHT 18.0
// 災害メモ
#define DISASTER_INFO_DISASTER_MEMO_LABEL_X            DISASTER_INFO_EMERGENCY_KIND_LABEL_X
#define DISASTER_INFO_DISASTER_MEMO_LABEL_Y            DISASTER_INFO_EMERGENCY_KIND_LABEL_Y + DISASTER_INFO_EMERGENCY_KIND_LABEL_HEIGHT + DEFAULT_SPAN
#define DISASTER_INFO_DISASTER_MEMO_LABEL_WIDTH        DISASTER_INFO_EMERGENCY_KIND_LABEL_WIDTH
#define DISASTER_INFO_DISASTER_MEMO_LABEL_HEIGHT       160.0

// トリアージラベル
#define DISASTER_INFO_TRIAGE_LABEL_X                    DISASTER_INFO_EMERGENCY_KIND_LABEL_X
//#define DISASTER_INFO_TRIAGE_LABEL_Y                    DISASTER_INFO_SPAN_Y + DISASTER_INFO_PICTURE_Y + DISASTER_INFO_PICTURE_HEIGHT
#define DISASTER_INFO_TRIAGE_LABEL_Y                    DISASTER_INFO_SPAN_Y + DISASTER_INFO_DISASTER_MEMO_LABEL_Y + DISASTER_INFO_DISASTER_MEMO_LABEL_HEIGHT
#define DISASTER_INFO_TRIAGE_LABEL_WIDTH                120.0
#define DISASTER_INFO_TRIAGE_LABEL_HEIGHT               DISASTER_INFO_FULL_NAME_LABEL_HEIGHT
// トリアージセグメント
#define DISASTER_INFO_TRIAGE_X                          DISASTER_INFO_EMERGENCY_KIND_LABEL_X
#define DISASTER_INFO_TRIAGE_Y							DISASTER_INFO_TRIAGE_LABEL_Y + DISASTER_INFO_TRIAGE_LABEL_HEIGHT
#define DISASTER_INFO_TRIAGE_WIDTH						150.0
#define DISASTER_INFO_TRIAGE_HEIGHT						25.0

// 対応完了セグメント
//#define DISASTER_INFO_DONE_KIND_X                      DISASTER_INFO_TRIAGE_X + DISASTER_INFO_TRIAGE_WIDTH + DEFAULT_SPAN
//#define DISASTER_INFO_DONE_KIND_Y                      DISASTER_INFO_TRIAGE_Y
#define DISASTER_INFO_DONE_KIND_X                      DISASTER_INFO_TRIAGE_X
#define DISASTER_INFO_DONE_KIND_Y                      DISASTER_INFO_TRIAGE_Y + DISASTER_INFO_TRIAGE_HEIGHT + DEFAULT_SPAN
#define DISASTER_INFO_DONE_KIND_WIDTH                  130.0
#define DISASTER_INFO_DONE_KIND_HEIGHT                 25.0

// 画像
#define DISASTER_INFO_PICTURE_X                         DISASTER_INFO_TRIAGE_X + DISASTER_INFO_TRIAGE_WIDTH + DEFAULT_SPAN * 6
//#define DISASTER_INFO_PICTURE_Y                         DISASTER_INFO_SPAN_Y + DISASTER_INFO_DISASTER_MEMO_LABEL_Y + DISASTER_INFO_DISASTER_MEMO_LABEL_HEIGHT
#define DISASTER_INFO_PICTURE_Y                         DISASTER_INFO_TRIAGE_Y - DEFAULT_SPAN * 2
#define DISASTER_INFO_PICTURE_WIDTH                     60.0     
#define DISASTER_INFO_PICTURE_HEIGHT                    60.0 //160.0


// 更新ボタン
#define DISASTER_INFO_UPDATE_BUTTON_X                  30.0
#define DISASTER_INFO_UPDATE_BUTTON_Y                  DISASTER_INFO_SPAN_Y * 2 + DISASTER_INFO_DONE_KIND_Y + DISASTER_INFO_DONE_KIND_HEIGHT
#define DISASTER_INFO_UPDATE_BUTTON_WIDTH              260.0
#define DISASTER_INFO_UPDATE_BUTTON_HEIGHT             30.0

//----------------------------------------------------
// 災害情報送信 DisasterInfoSendViewControllerで使用
//----------------------------------------------------
#define DISASTER_SEND_FONT_SIZE                      14

// 家族リストピッカービュー
#define DISASTER_SEND_FAMILY_LIST_PICKER_X            0
#define DISASTER_SEND_FAMILY_LIST_PICKER_Y            0
#define DISASTER_SEND_FAMILY_LIST_PICKER_WIDTH        300	// TODO
#define DISASTER_SEND_FAMILY_LIST_PICKER_HEIGHT       100	// TODO
// 緊急度・状況ピッカービュー
#define DISASTER_SEND_EMERGENCY_LIST_PICKER_X         0
#define DISASTER_SEND_EMERGENCY_LIST_PICKER_Y         0
#define DISASTER_SEND_EMERGENCY_LIST_PICKER_WIDTH     320
#define DISASTER_SEND_EMERGENCY_LIST_PICKER_HEIGHT    100
// 現在位置取得アイコン
#define DISASTER_SEND_LOCATION_OFF_ICON_X             25
#define DISASTER_SEND_LOCATION_OFF_ICON_Y             230
#define DISASTER_SEND_LOCATION_OFF_ICON_WIDTH         120
#define DISASTER_SEND_LOCATION_OFF_ICON_HEIGHT        80
// 現在位置削除アイコン
#define DISASTER_SEND_LOCATION_ON_ICON_X              DISASTER_SEND_LOCATION_OFF_ICON_X
#define DISASTER_SEND_LOCATION_ON_ICON_Y              DISASTER_SEND_LOCATION_OFF_ICON_Y
#define DISASTER_SEND_LOCATION_ON_ICON_WIDTH          DISASTER_SEND_LOCATION_OFF_ICON_WIDTH
#define DISASTER_SEND_LOCATION_ON_ICON_HEIGHT         DISASTER_SEND_LOCATION_OFF_ICON_HEIGHT
// 写真撮影アイコン
#define DISASTER_SEND_PHOTO_OFF_ICON_X                175
#define DISASTER_SEND_PHOTO_OFF_ICON_Y                DISASTER_SEND_LOCATION_OFF_ICON_Y
#define DISASTER_SEND_PHOTO_OFF_ICON_WIDTH            DISASTER_SEND_LOCATION_OFF_ICON_WIDTH
#define DISASTER_SEND_PHOTO_OFF_ICON_HEIGHT           DISASTER_SEND_LOCATION_OFF_ICON_HEIGHT
// 写真削除アイコン
#define DISASTER_SEND_PHOTO_ON_ICON_X                 DISASTER_SEND_PHOTO_OFF_ICON_X
#define DISASTER_SEND_PHOTO_ON_ICON_Y                 DISASTER_SEND_PHOTO_OFF_ICON_Y
#define DISASTER_SEND_PHOTO_ON_ICON_WIDTH             DISASTER_SEND_PHOTO_OFF_ICON_WIDTH
#define DISASTER_SEND_PHOTO_ON_ICON_HEIGHT            DISASTER_SEND_PHOTO_OFF_ICON_HEIGHT
// 現在位置添付アイコン
#define DISASTER_SEND_MARKER_ICON_X                   DISASTER_SEND_LOCATION_ON_ICON_X + DISASTER_SEND_LOCATION_ON_ICON_WIDTH
#define DISASTER_SEND_MARKER_ICON_Y                   DISASTER_SEND_LOCATION_OFF_ICON_Y + DISASTER_SEND_LOCATION_OFF_ICON_HEIGHT - 26
#define DISASTER_SEND_MARKER_ICON_WIDTH               16
#define DISASTER_SEND_MARKER_ICON_HEIGHT              26
// 写真添付アイコン
#define DISASTER_SEND_CLIP_ICON_X                     DISASTER_SEND_PHOTO_OFF_ICON_X + DISASTER_SEND_PHOTO_OFF_ICON_WIDTH
#define DISASTER_SEND_CLIP_ICON_Y                     DISASTER_SEND_PHOTO_OFF_ICON_Y + DISASTER_SEND_PHOTO_OFF_ICON_HEIGHT - 26
#define DISASTER_SEND_CLIP_ICON_WIDTH                 14
#define DISASTER_SEND_CLIP_ICON_HEIGHT                26

// 災害メモ
#define DISASTER_SEND_DISASTER_MEMO_X                 DISASTER_SEND_LOCATION_OFF_ICON_X
#define DISASTER_SEND_DISASTER_MEMO_Y                 DISASTER_SEND_PHOTO_OFF_ICON_Y + DISASTER_SEND_PHOTO_OFF_ICON_HEIGHT + DEFAULT_SPAN * 2
#define DISASTER_SEND_DISASTER_MEMO_WIDTH             320 - 50
#define DISASTER_SEND_DISASTER_MEMO_HEIGHT            35 

//----------------------------------------------------
// 災害情報送信(PickerView) DisasterPickerViewで使用
//----------------------------------------------------
// フォントサイズ
#define DISASTER_PICKERVIEW_FONT_SIZE                 14

#define DISASTER_PICKERVIEW_LABEL_X                   -47.0
#define DISASTER_PICKERVIEW_LABEL_Y                   -11.0
#define DISASTER_PICKERVIEW_LABEL_WIDTH               95.0
#define DISASTER_PICKERVIEW_LABEL_HEIGHT              25.0

// ラベル コンポーネント０（氏名）
#define DISASTER_PICKERVIEW_LABEL_COMP_0_X            DISASTER_PICKERVIEW_LABEL_X
#define DISASTER_PICKERVIEW_LABEL_COMP_0_Y            DISASTER_PICKERVIEW_LABEL_Y
#define DISASTER_PICKERVIEW_LABEL_COMP_0_WIDTH        DISASTER_PICKERVIEW_LABEL_WIDTH
#define DISASTER_PICKERVIEW_LABEL_COMP_0_HEIGHT       DISASTER_PICKERVIEW_LABEL_HEIGHT
// ラベル コンポーネント１（緊急度）
#define DISASTER_PICKERVIEW_LABEL_COMP_1_X            DISASTER_PICKERVIEW_LABEL_X
#define DISASTER_PICKERVIEW_LABEL_COMP_1_Y            DISASTER_PICKERVIEW_LABEL_Y
#define DISASTER_PICKERVIEW_LABEL_COMP_1_WIDTH        65.0
#define DISASTER_PICKERVIEW_LABEL_COMP_1_HEIGHT       DISASTER_PICKERVIEW_LABEL_HEIGHT
// ラベル コンポーネント２（状況）
#define DISASTER_PICKERVIEW_LABEL_COMP_2_X            DISASTER_PICKERVIEW_LABEL_X
#define DISASTER_PICKERVIEW_LABEL_COMP_2_Y            DISASTER_PICKERVIEW_LABEL_Y
#define DISASTER_PICKERVIEW_LABEL_COMP_2_WIDTH        125.0
#define DISASTER_PICKERVIEW_LABEL_COMP_2_HEIGHT       DISASTER_PICKERVIEW_LABEL_HEIGHT
// コンポーネント０（氏名）幅
#define DISASTER_PICKERVIEW_COMP_0_WIDTH              DISASTER_PICKERVIEW_LABEL_COMP_0_WIDTH + DEFAULT_SPAN
// コンポーネント１（緊急度）幅
#define DISASTER_PICKERVIEW_COMP_1_WIDTH              DISASTER_PICKERVIEW_LABEL_COMP_1_WIDTH + DEFAULT_SPAN
// コンポーネント２（状況）幅
#define DISASTER_PICKERVIEW_COMP_2_WIDTH              DISASTER_PICKERVIEW_LABEL_COMP_2_WIDTH + DEFAULT_SPAN
// コンポーネント高さ幅
#define DISASTER_PICKERVIEW_COMP_HEIGHT               DISASTER_PICKERVIEW_LABEL_HEIGHT + 3.0

//----------------------------------------------------
// 災害情報（画像表示） SafetyConfirmViewCellで使用
//----------------------------------------------------
#define SAFETY_CONFIRM_FONT_SIZE                    17
#define SAFETY_CONFIRM_FONT_SMALL_SIZE              14

// 氏名
#define SAFETY_CONFIRM_FULL_NAME_X                  DEFAULT_SPAN
#define SAFETY_CONFIRM_FULL_NAME_Y                  DEFAULT_SPAN
#define SAFETY_CONFIRM_FULL_NAME_WIDTH              130
#define SAFETY_CONFIRM_FULL_NAME_HEIGHT             35
// 状況セグメント
#define SAFETY_CONFIRM_STATUS_SEGMENTED_X           SAFETY_CONFIRM_FULL_NAME_X + SAFETY_CONFIRM_FULL_NAME_WIDTH
#define SAFETY_CONFIRM_STATUS_SEGMENTED_Y           DEFAULT_SPAN + 3.0
#define SAFETY_CONFIRM_STATUS_SEGMENTED_WIDTH       160
#define SAFETY_CONFIRM_STATUS_SEGMENTED_HEIGHT      30

//----------------------------------------------------
// 安否確認 PhotoViewControllerで使用
//----------------------------------------------------
// 画像
#define PHOTO_VIEW_X                                0.0
#define PHOTO_VIEW_Y                                -20.0
#define PHOTO_VIEW_WIDTH                            320
#define PHOTO_VIEW_HIEGHT                           460

//----------------------------------------------------
// 設定 SettingsViewCellで使用
//----------------------------------------------------
#define SETTINGS_FONT_SIZE                          18
#define SETTINGS_FONT_SMALL_SIZE                    18

// タイトルラベル
#define SETTINGS_TITLE_LABEL_X                      20.0
#define SETTINGS_TITLE_LABEL_Y                      5.0
#define SETTINGS_TITLE_LABEL_WIDTH                  100.0
#define SETTINGS_TITLE_LABEL_HEIGHT                 35.0
// 入力テキスト
#define SETTINGS_INPUT_TEXT_X                       SETTINGS_TITLE_LABEL_X + SETTINGS_TITLE_LABEL_WIDTH
#define SETTINGS_INPUT_TEXT_Y                       SETTINGS_TITLE_LABEL_Y
#define SETTINGS_INPUT_TEXT_WIDTH                   180.0
#define SETTINGS_INPUT_TEXT_HEIGHT                  SETTINGS_TITLE_LABEL_HEIGHT


